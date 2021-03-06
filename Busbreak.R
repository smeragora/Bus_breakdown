#first import data set
#make an empty matrix and change it to a matrix 
#use Sys.time to find how long this takes to run
#the for loop subsets and imputs the data into the empty data frame
uniqueReason<-unique(busbreakdown$Reason)
result<-matrix(0,nrow=10,ncol=2)
result<-as.data.frame(result)
colnames(result)<-c("Type","count")
t1=Sys.time()
for (i in 1:length(uniqueReason)){
  temp<-subset(busbreakdown, busbreakdown$Reason==uniqueReason[i])
  result$Type[i]=uniqueReason[i]
  result$count[i]= length(temp$Reason)
}
t2=Sys.time()

t2-t1


#assign all values to 0
#using a for loop to see where that variable comes up and add one every time it does to check the frequency
Other<-0
MechanicalProblem<-0
HeavyTraffic<-0
ProblemRun<-0
WontStart<-0
FlatTire<-0
WeatherConditions<-0
Accident<-0
DelayedbySchool<-0
LatereturnfromFieldTrip<-0

t3<-Sys.time()
for(i in 1:length(busbreakdown$Reason)){
  print(i)
  if(busbreakdown$Reason[i]=="Other"){
    Other = Other+1
    }
  if(busbreakdown$Reason[i]=="Mechanical Problem"){
    MechanicalProblem+1
  }
  if(busbreakdown$Reason[i]=="Heavy Traffic"){
    HeavyTraffic=HeavyTraffic+1
  }
  if(busbreakdown$Reason[i]=="Problem Run"){
    ProblemRun=ProblemRun+1
  }
  if(busbreakdown$Reason[i]=="Won't Start"){
    WontStart= WontStart+1
  }
  if(busbreakdown$Reason[i]=="Flat Tire"){
    FlatTire = FlatTire+1
  }
  if(busbreakdown$Reason[i]=="Weather Conditions"){
    WeatherConditions = WeatherConditions+1
  }
  if(busbreakdown$Reason[i]=="Accident"){
    Accident=Accident+1
  }
  if(busbreakdown$Reason[i]=="Delayed by School"){
    DelayedbySchool = DelayedbySchool+1
  }
  if(busbreakdown$Reason[i]=="Late return from Field Trip"){
    LatereturnfromFieldTrip = LatereturnfromFieldTrip+1
  }
}
t4=Sys.time()
t4-t3

#this is an efficient way to find the frequency of reasons. 
t5<-Sys.time()
plyr::count(busbreakdown$Reason)
t6<-Sys.time()
t6-t5


#from main data frame
#table 
#find the unique number of routes and reasons to find out how many times you need to loop through
#I had an extra reason that was empty so I specified 1:10
uniqueReason<-unique(busbreakdown$Reason)
uniqueRouteNumber<-unique(busbreakdown$Route_Number)
answer<-matrix(0,nrow=length(uniqueRouteNumber),ncol=10)
answer<-as.data.frame(answer)
colnames(answer)<-c(uniqueReason[1:10])
rownames(answer)<-c(uniqueRouteNumber)


#for every unique route check reason. This goes to each route and checks the reasons
#This will fill in row by row 

t8<-Sys.time()
for (i in 1:length(uniqueRouteNumber)) {


  for(j in 1: length(uniqueReason[1:10])){
    temp1<-subset(busbreakdown, busbreakdown$Route_Number==uniqueRouteNumber[i] 
     
                  
                             & busbreakdown$Reason==uniqueReason[j])
    
    
    answer[i,j]<-length(temp1$Reason)
      }
}
View(answer)
t9<-Sys.time()
t9-t8



#This is the most efficient way to find frequency, but the layout is not the same.
plyr::count(busbreakdown, c("Route_Number","Reason"))

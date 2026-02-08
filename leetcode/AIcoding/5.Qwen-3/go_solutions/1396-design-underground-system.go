package main

type UndergroundSystem struct {
	checkInMap map[int]*CheckIn
	averageMap map[string]Average
}

type CheckIn struct {
	userId int
	startStation string
	time int
}

type Average struct {
	totalTime int
	count int
}

func Constructor() UndergroundSystem {
	return UndergroundSystem{
		checkInMap: make(map[int]*CheckIn),
		averageMap: make(map[string]Average),
	}
}

func (this *UndergroundSystem) CheckIn(id int, stationName string, t int) {
	this.checkInMap[id] = &CheckIn{
		userId: id,
		startStation: stationName,
		time: t,
	}
}

func (this *UndergroundSystem) CheckOut(id int, stationName string, t int) {
	checkIn := this.checkInMap[id]
	delete(this.checkInMap, id)
	key := checkIn.startStation + "," + stationName
	avg := this.averageMap[key]
	avg.totalTime += t - checkIn.time
	avg.count++
	this.averageMap[key] = avg
}

func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
	key := startStation + "," + endStation
	avg := this.averageMap[key]
	return float64(avg.totalTime) / float64(avg.count)
}
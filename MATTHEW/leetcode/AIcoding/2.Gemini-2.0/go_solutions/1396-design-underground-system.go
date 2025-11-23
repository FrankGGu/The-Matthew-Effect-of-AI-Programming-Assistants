type UndergroundSystem struct {
	checkInMap  map[int]CheckInData
	travelStats map[string]TravelStats
}

type CheckInData struct {
	stationName string
	t           int
}

type TravelStats struct {
	totalTime int
	count     int
}

func Constructor() UndergroundSystem {
	return UndergroundSystem{
		checkInMap:  make(map[int]CheckInData),
		travelStats: make(map[string]TravelStats),
	}
}

func (this *UndergroundSystem) CheckIn(id int, stationName string, t int) {
	this.checkInMap[id] = CheckInData{stationName: stationName, t: t}
}

func (this *UndergroundSystem) CheckOut(id int, stationName string, t int) {
	checkInData := this.checkInMap[id]
	delete(this.checkInMap, id)

	startStation := checkInData.stationName
	startTime := checkInData.t
	key := startStation + "," + stationName

	stats := this.travelStats[key]
	stats.totalTime += t - startTime
	stats.count++
	this.travelStats[key] = stats
}

func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
	key := startStation + "," + endStation
	stats := this.travelStats[key]
	return float64(stats.totalTime) / float64(stats.count)
}
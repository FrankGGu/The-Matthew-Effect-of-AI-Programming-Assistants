type CheckIn struct {
    station string
    time    int
}

type UndergroundSystem struct {
    checkIns map[int]CheckIn
    travels  map[string]map[string][]int
}

func Constructor() UndergroundSystem {
    return UndergroundSystem{
        checkIns: make(map[int]CheckIn),
        travels:  make(map[string]map[string][]int),
    }
}

func (this *UndergroundSystem) CheckIn(id int, stationName string, t int) {
    this.checkIns[id] = CheckIn{stationName, t}
}

func (this *UndergroundSystem) CheckOut(id int, stationName string, t int) {
    checkIn := this.checkIns[id]
    startStation := checkIn.station
    startTime := checkIn.time
    delete(this.checkIns, id)

    if _, ok := this.travels[startStation]; !ok {
        this.travels[startStation] = make(map[string][]int)
    }
    this.travels[startStation][stationName] = append(this.travels[startStation][stationName], t-startTime)
}

func (this *UndergroundSystem) GetAverageTime(startStation string, endStation string) float64 {
    times := this.travels[startStation][endStation]
    sum := 0
    for _, t := range times {
        sum += t
    }
    return float64(sum) / float64(len(times))
}
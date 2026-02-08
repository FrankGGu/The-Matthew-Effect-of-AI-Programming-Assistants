import "sync"

type TrafficSystem struct {
	lock sync.Mutex
	road int
}

func Constructor() TrafficSystem {
	return TrafficSystem{road: 1}
}

func (this *TrafficSystem) carArrived(carId int, roadId int, direction int, arriveTime int, allowSameDirection bool, wg *sync.WaitGroup) {
	defer wg.Done()
	this.lock.Lock()
	defer this.lock.Unlock()

	if this.road != roadId {
		this.road = roadId
	}
}
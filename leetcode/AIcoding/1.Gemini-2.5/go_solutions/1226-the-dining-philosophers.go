import "sync"

type DiningPhilosophers struct {
	chopsticks [5]sync.Mutex
	limit      chan struct{}
}

func Constructor() *DiningPhilosophers {
	dp := &DiningPhilosophers{
		limit: make(chan struct{}, 4),
	}
	return dp
}

func (dp *DiningPhilosophers) Eats(philosopher int, pickLeft func(), pickRight func(), eat func(), putLeft func(), putRight func()) {
	dp.limit <- struct{}{}

	leftChopstick := philosopher
	rightChopstick := (philosopher + 1) % 5

	dp.chopsticks[leftChopstick].Lock()
	pickLeft()

	dp.chopsticks[rightChopstick].Lock()
	pickRight()

	eat()

	dp.chopsticks[rightChopstick].Unlock()
	putRight()

	dp.chopsticks[leftChopstick].Unlock()
	putLeft()

	<-dp.limit
}
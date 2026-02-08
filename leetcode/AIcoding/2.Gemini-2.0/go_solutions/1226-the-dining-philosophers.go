import (
	"sync"
)

type DiningPhilosophers struct {
	forks [5]sync.Mutex
	order chan int
}

func Constructor() *DiningPhilosophers {
	return &DiningPhilosophers{
		forks: [5]sync.Mutex{},
		order: make(chan int, 1),
	}
}

func (this *DiningPhilosophers) wantsToEat(philosopher int,
	pickLeftFork func(),
	pickRightFork func(),
	eat func(),
	putLeftFork func(),
	putRightFork func()) {

	<-this.order
	leftFork := philosopher
	rightFork := (philosopher + 1) % 5

	this.forks[leftFork].Lock()
	pickLeftFork()
	this.forks[rightFork].Lock()
	pickRightFork()

	eat()

	putLeftFork()
	this.forks[leftFork].Unlock()
	putRightFork()
	this.forks[rightFork].Unlock()

	this.order <- 1
}
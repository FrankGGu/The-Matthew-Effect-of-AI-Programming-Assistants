package main

type DiningPhilosophers struct {
	mutexes []*sync.Mutex
}

func Constructor() DiningPhilosophers {
	return DiningPhilosophers{
		mutexes: make([]*sync.Mutex, 5),
	}
}

func (d *DiningPhilosophers) wantsToEat(
	philosopher int,
	pickLeftFork func(),
	pickRightFork func(),
	eat func(),
	putLeftFork func(),
	putRightFork func(),
) {
	left := philosopher
	right := (philosopher + 1) % 5

	if philosopher%2 == 0 {
		d.mutexes[left].Lock()
		pickLeftFork()
		d.mutexes[right].Lock()
		pickRightFork()
	} else {
		d.mutexes[right].Lock()
		pickRightFork()
		d.mutexes[left].Lock()
		pickLeftFork()
	}

	eat()

	putLeftFork()
	d.mutexes[left].Unlock()
	putRightFork()
	d.mutexes[right].Unlock()
}
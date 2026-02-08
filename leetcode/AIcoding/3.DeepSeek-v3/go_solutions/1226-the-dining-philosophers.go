type DiningPhilosophers struct {
	forks [5]sync.Mutex
}

func (dp *DiningPhilosophers) wantsToEat(philosopher int, pickLeftFork func(), pickRightFork func(), eat func(), putLeftFork func(), putRightFork func()) {
	left := philosopher
	right := (philosopher + 1) % 5

	if philosopher%2 == 0 {
		dp.forks[left].Lock()
		pickLeftFork()
		dp.forks[right].Lock()
		pickRightFork()
	} else {
		dp.forks[right].Lock()
		pickRightFork()
		dp.forks[left].Lock()
		pickLeftFork()
	}

	eat()

	putLeftFork()
	dp.forks[left].Unlock()
	putRightFork()
	dp.forks[right].Unlock()
}
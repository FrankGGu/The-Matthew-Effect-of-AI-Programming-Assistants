package main

import (
	"sync"
	"time"
)

type DiningPhilosophers struct {
	forks []sync.Mutex
}

func Constructor() DiningPhilosophers {
	return DiningPhilosophers{forks: make([]sync.Mutex, 5)}
}

func (dp *DiningPhilosophers) WantsToEat(philosopher int, pickFirstFork func(int), pickSecondFork func(int), eat func(int), putForks func(int)) {
	left := philosopher
	right := (philosopher + 1) % 5

	if philosopher%2 == 0 {
		pickFirstFork(left)
		dp.forks[left].Lock()
		pickSecondFork(right)
		dp.forks[right].Lock()
	} else {
		pickSecondFork(right)
		dp.forks[right].Lock()
		pickFirstFork(left)
		dp.forks[left].Lock()
	}

	eat(philosopher)

	putForks(philosopher)
	dp.forks[left].Unlock()
	dp.forks[right].Unlock()
}
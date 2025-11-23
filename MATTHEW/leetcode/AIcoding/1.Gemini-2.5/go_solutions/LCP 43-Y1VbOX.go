package main

import (
	"container/heap"
	"sort"
)

type Car struct {
	ID          int
	ArrivalTime int
	ProcessTime int
}

type ArrivingCars []Car

func (c ArrivingCars) Len() int { return len(c) }
func (c ArrivingCars) Less(i, j int) bool {
	if c[i].ArrivalTime != c[j].ArrivalTime {
		return c[i].ArrivalTime < c[j].ArrivalTime
	}
	return c[i].ID < c[j].ID
}
func (c ArrivingCars) Swap(i, j int) { c[i], c[j] = c[j], c[i] }

type ProcessableCars []Car

func (pc ProcessableCars) Len() int { return len(pc) }
func (pc ProcessableCars) Less(i, j int) bool {
	if pc[i].ProcessTime != pc[j].ProcessTime {
		return pc[i].ProcessTime < pc[j].ProcessTime
	}
	return pc[i].ID < pc[j].ID
}
func (pc ProcessableCars) Swap(i, j int) { pc[i], pc[j] = pc[j], pc[i] }

func (pc *ProcessableCars) Push(x interface{}) {
	*pc = append(*pc, x.(Car))
}

func (pc *ProcessableCars) Pop() interface{} {
	old := *pc
	n := len(old)
	item := old[n-1]
	*pc = old[0 : n-1]
	*pc = old[0 : n-1]
	return item
}

func trafficAtIntersection(arriveTime []int, processTime []int) int {
	n := len(arriveTime)
	if n == 0 {
		return 0
	}

	allCars := make([]Car, n)
	for i := 0; i < n; i++ {
		allCars[i] = Car{ID: i, ArrivalTime: arriveTime[i], ProcessTime: processTime[i]}
	}

	sort.Slice(allCars, func(i, j int) bool {
		if allCars[i].ArrivalTime != allCars[j].ArrivalTime {
			return allCars[i].ArrivalTime < allCars[j].ArrivalTime
		}
		return allCars[i].ID < allCars[j].ID
	})

	processable := &ProcessableCars{}
	heap.Init(processable)

	currentTime := 0
	carIdx := 0
	totalCompletionTime := 0

	for carIdx < n || processable.Len() > 0 {
		if processable.Len() == 0 && carIdx < n && currentTime < allCars[carIdx].ArrivalTime {
			currentTime = allCars[carIdx].ArrivalTime
		}

		for carIdx < n && allCars[carIdx].ArrivalTime <= currentTime {
			heap.Push(processable, allCars[carIdx])
			carIdx++
		}

		if processable.Len() > 0 {
			car := heap.Pop(processable).(Car)
			currentTime += car.ProcessTime
			totalCompletionTime = currentTime
		}
	}

	return totalCompletionTime
}
package main

import (
	"container/heap"
	"math"
)

type WorkerAvailability struct {
	crossingTime int
	workerID     int
}

type WorkerAvailabilityHeap []WorkerAvailability

func (h WorkerAvailabilityHeap) Len() int { return len(h) }
func (h WorkerAvailabilityHeap) Less(i, j int) bool {
	if h[i].crossingTime != h[j].crossingTime {
		return h[i].crossingTime < h[j].crossingTime // Smallest crossingTime first
	}
	return h[i].workerID > h[j].workerID // Largest workerID first (for ties)
}
func (h WorkerAvailabilityHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *WorkerAvailabilityHeap) Push(x interface{}) {
	*h = append(*h, x.(WorkerAvailability))
}

func (h *WorkerAvailabilityHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

type LoadingWorker struct {
	finishTime int
	workerID   int
}

type LoadingWorkerHeap []LoadingWorker

func (h LoadingWorkerHeap) Len() int { return len(h) }
func (h LoadingWorkerHeap) Less(i, j int) bool {
	if h[i].finishTime != h[j].finishTime {
		return h[i].finishTime < h[j].finishTime // Smallest finishTime first
	}
	return h[i].workerID < h[j].workerID // Smallest workerID first (for ties)
}
func (h LoadingWorkerHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *LoadingWorkerHeap) Push(x interface{}) {
	*h = append(*h, x.(LoadingWorker))
}

func (h *LoadingWorkerHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func findCrossingTime(n int, k int, workers [][]int) int {
	time := 0
	boxesCrossed := 0

	availableLeft := &WorkerAvailabilityHeap{}
	heap.Init(availableLeft)

	availableRight := &WorkerAvailabilityHeap{}
	heap.Init(availableRight)

	loadingLeft := &LoadingWorkerHeap{}
	heap.Init(loadingLeft)

	loadingRight := &LoadingWorkerHeap{}
	heap.Init(loadingRight)

	// Initialize availableLeft with all workers
	for i := 0; i < n; i++ {
		heap.Push(availableLeft, WorkerAvailability{crossingTime: workers[i][0], workerID: i})
	}

	for boxesCrossed < k {
		// 1. Move workers from loading queues to available queues whose loading is finished by `time`.
		// This must be done *before* checking who crosses, as advancing time might have freed workers.
		for loadingLeft.Len() > 0 && loadingLeft.Peek().(LoadingWorker).finishTime <= time {
			item := heap.Pop(loadingLeft).(LoadingWorker)
			heap.Push(availableLeft, WorkerAvailability{crossingTime: workers[item.workerID][0], workerID: item.workerID})
		}
		for loadingRight.Len() > 0 && loadingRight.Peek().(LoadingWorker).finishTime <= time {
			item := heap.Pop(loadingRight).(LoadingWorker)
			heap.Push(availableRight, WorkerAvailability{crossingTime: workers[item.workerID][1], workerID: item.workerID})
		}

		// 2. If no one is available to cross, we must advance time to the next event.
		if availableLeft.Len() == 0 && availableRight.Len() == 0 {
			if loadingLeft.Len() == 0 && loadingRight.Len() == 0 {
				// This case should not be reached if k > boxesCrossed.
				// It means no workers are available and no workers are loading, so no progress can be made.
				// This implies an issue with problem constraints or logic.
				break
			}

			minNextEventTime := math.MaxInt64
			if loadingLeft.Len() > 0 {
				minNextEventTime = min(minNextEventTime, loadingLeft.Peek().(LoadingWorker).finishTime)
			}
			if loadingRight.Len() > 0 {
				minNextEventTime = min(minNextEventTime, loadingRight.Peek().(LoadingWorker).finishTime)
			}
			time = minNextEventTime
			continue // Re-evaluate state after time jump
		}

		// 3. Decide who crosses. Prioritize right-to-left.
		if availableRight.Len() > 0 {
			item := heap.Pop(availableRight).(WorkerAvailability)
			workerID := item.workerID
			time += workers[workerID][1] // Add rightToLeftTime
			heap.Push(loadingLeft, LoadingWorker{finishTime: time + workers[workerID][0], workerID: workerID})
		} else { // availableLeft.Len() > 0 must be true if we didn't hit 'continue'
			item := heap.Pop(availableLeft).(WorkerAvailability)
			workerID := item.workerID
			time += workers[workerID][0] // Add leftToRightTime
			heap.Push(loadingRight, LoadingWorker{finishTime: time + workers[workerID][1], workerID: workerID})
			boxesCrossed++
		}
	}

	return time
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
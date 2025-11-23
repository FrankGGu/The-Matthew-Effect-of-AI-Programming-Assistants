import (
	"container/heap"
)

type Worker struct {
	id   int
	time int
}

type BridgeHeap []Worker

func (h BridgeHeap) Len() int           { return len(h) }
func (h BridgeHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h BridgeHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *BridgeHeap) Push(x interface{}) {
	*h = append(*h, x.(Worker))
}

func (h *BridgeHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type WorkerHeap []Worker

func (h WorkerHeap) Len() int           { return len(h) }
func (h WorkerHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h WorkerHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *WorkerHeap) Push(x interface{}) {
	*h = append(*h, x.(Worker))
}

func (h *WorkerHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func timeToCross(numWorkers int, bridgeTime []int, time int) int {
	left := &WorkerHeap{}
	right := &BridgeHeap{}
	for i := 0; i < numWorkers; i++ {
		heap.Push(left, Worker{i, bridgeTime[i]})
	}

	currentTime := 0
	leftWorkers := numWorkers
	rightWorkers := 0

	for time > 0 || rightWorkers > 0 {
		for right.Len() > 0 && right.(*BridgeHeap)[0].time <= currentTime {
			worker := heap.Pop(right).(Worker)
			heap.Push(left, Worker{worker.id, bridgeTime[worker.id]})
			leftWorkers++
			rightWorkers--
		}
		if left.Len() == 0 && right.Len() == 0 {
			currentTime = right.(*BridgeHeap)[0].time
			continue
		}
		if left.Len() == 0 {
			currentTime = right.(*BridgeHeap)[0].time
			continue
		}

		if leftWorkers > 1 {
			maxTime := 0
			worker1Index := -1
			worker2Index := -1
			tempLeft := &WorkerHeap{}
			for left.Len() > 0 {
				worker := heap.Pop(left).(Worker)
				heap.Push(tempLeft, worker)
			}
			workers := []Worker{}
			for tempLeft.Len() > 0 {
				worker := heap.Pop(tempLeft).(Worker)
				workers = append(workers, worker)
				heap.Push(left, worker)
			}

			for i := 0; i < len(workers); i++ {
				for j := i + 1; j < len(workers); j++ {
					if workers[i].time+workers[j].time > maxTime {
						maxTime = workers[i].time + workers[j].time
						worker1Index = i
						worker2Index = j
					}
				}
			}

			worker1 := workers[worker1Index]
			worker2 := workers[worker2Index]
			currentTime += maxTime
			heap.Push(right, Worker{worker1.id, currentTime + bridgeTime[worker1.id] + bridgeTime[worker1.id+numWorkers]})
			heap.Push(right, Worker{worker2.id, currentTime + bridgeTime[worker2.id] + bridgeTime[worker2.id+numWorkers]})

			newLeft := &WorkerHeap{}
			for left.Len() > 0 {
				worker := heap.Pop(left).(Worker)
				if worker.id != worker1.id && worker.id != worker2.id {
					heap.Push(newLeft, worker)
				}
			}
			left = newLeft

			leftWorkers -= 2
			rightWorkers += 2
		} else {
			worker := heap.Pop(left).(Worker)
			currentTime += bridgeTime[worker.id] + bridgeTime[worker.id+numWorkers]
			time--
			leftWorkers--
			rightWorkers++
		}
	}

	return currentTime
}
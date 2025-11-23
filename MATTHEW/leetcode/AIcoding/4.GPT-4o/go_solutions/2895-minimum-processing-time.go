package main

import (
	"container/heap"
	"fmt"
)

type Job struct {
	time int
	index int
}

type MinHeap []Job

func (h MinHeap) Len() int { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].time < h[j].time }
func (h MinHeap) Swap(i, j int) { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Job))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func minimumProcessingTime(neededTime []int) int {
	n := len(neededTime)
	h := &MinHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		heap.Push(h, Job{time: neededTime[i], index: i})
	}

	totalTime := 0
	for h.Len() > 0 {
		job := heap.Pop(h).(Job)
		totalTime += job.time
	}

	return totalTime
}

func main() {
	neededTime := []int{1, 2, 3, 4}
	fmt.Println(minimumProcessingTime(neededTime))
}
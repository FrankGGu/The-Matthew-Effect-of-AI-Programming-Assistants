package main

import (
	"container/heap"
	"sort"
)

type Task struct {
	EnqueueTime    int
	ProcessingTime int
	OriginalIndex  int
}

type PriorityQueue []*Task

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].ProcessingTime != pq[j].ProcessingTime {
		return pq[i].ProcessingTime < pq[j].ProcessingTime
	}
	return pq[i].OriginalIndex < pq[j].OriginalIndex
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*Task)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func getOrder(tasks [][]int) []int {
	n := len(tasks)
	if n == 0 {
		return []int{}
	}

	augmentedTasks := make([]*Task, n)
	for i := 0; i < n; i++ {
		augmentedTasks[i] = &Task{
			EnqueueTime:    tasks[i][0],
			ProcessingTime: tasks[i][1],
			OriginalIndex:  i,
		}
	}

	sort.Slice(augmentedTasks, func(i, j int) bool {
		return augmentedTasks[i].EnqueueTime < augmentedTasks[j].EnqueueTime
	})

	result := make([]int, 0, n)
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)

	currentTime := 0
	taskPointer := 0

	for len(result) < n {
		for taskPointer < n && augmentedTasks[taskPointer].EnqueueTime <= currentTime {
			heap.Push(&pq, augmentedTasks[taskPointer])
			taskPointer++
		}

		if pq.Len() == 0 {
			if taskPointer < n {
				currentTime = max(currentTime, augmentedTasks[taskPointer].EnqueueTime)
			}
		} else {
			task := heap.Pop(&pq).(*Task)
			result = append(result, task.OriginalIndex)
			currentTime += task.ProcessingTime
		}
	}

	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
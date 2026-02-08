func getOrder(tasks [][]int) []int {
	n := len(tasks)
	indexedTasks := make([][]int, n)
	for i := 0; i < n; i++ {
		indexedTasks[i] = []int{tasks[i][0], tasks[i][1], i}
	}

	sort.Slice(indexedTasks, func(i, j int) bool {
		return indexedTasks[i][0] < indexedTasks[j][0]
	})

	pq := &PriorityQueue{}
	heap.Init(pq)

	result := make([]int, 0, n)
	currentTime := 0
	taskIndex := 0

	for len(result) < n {
		for taskIndex < n && indexedTasks[taskIndex][0] <= currentTime {
			heap.Push(pq, indexedTasks[taskIndex])
			taskIndex++
		}

		if pq.Len() == 0 {
			if taskIndex < n {
				currentTime = indexedTasks[taskIndex][0]
			} else {
				break
			}
			continue
		}

		task := heap.Pop(pq).([]int)
		result = append(result, task[2])
		currentTime += task[1]
	}

	return result
}

import (
	"container/heap"
	"sort"
)

type PriorityQueue [][]int

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i][1] != pq[j][1] {
		return pq[i][1] < pq[j][1]
	}
	return pq[i][2] < pq[j][2]
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.([]int)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}
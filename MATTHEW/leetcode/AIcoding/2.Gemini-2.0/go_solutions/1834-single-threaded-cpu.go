import (
	"container/heap"
	"sort"
)

type Task struct {
	enqueueTime int
	processingTime int
	index int
}

type PriorityQueue []*Task

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	if pq[i].processingTime != pq[j].processingTime {
		return pq[i].processingTime < pq[j].processingTime
	}
	return pq[i].index < pq[j].index
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
	old[n-1] = nil 
	*pq = old[0 : n-1]
	return item
}

func getOrder(tasks [][]int) []int {
	n := len(tasks)
	indexedTasks := make([]*Task, n)
	for i := 0; i < n; i++ {
		indexedTasks[i] = &Task{enqueueTime: tasks[i][0], processingTime: tasks[i][1], index: i}
	}

	sort.Slice(indexedTasks, func(i, j int) bool {
		return indexedTasks[i].enqueueTime < indexedTasks[j].enqueueTime
	})

	result := make([]int, 0, n)
	pq := &PriorityQueue{}
	heap.Init(pq)

	currentTime := 0
	taskIndex := 0

	for len(result) < n {
		for taskIndex < n && indexedTasks[taskIndex].enqueueTime <= currentTime {
			heap.Push(pq, indexedTasks[taskIndex])
			taskIndex++
		}

		if pq.Len() == 0 {
			if taskIndex < n {
				currentTime = indexedTasks[taskIndex].enqueueTime
			} else {
				break
			}
			continue
		}

		task := heap.Pop(pq).(*Task)
		result = append(result, task.index)
		currentTime += task.processingTime

	}
	return result
}
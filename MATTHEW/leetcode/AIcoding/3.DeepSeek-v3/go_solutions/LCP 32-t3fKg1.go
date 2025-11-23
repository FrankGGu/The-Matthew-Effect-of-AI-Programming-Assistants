import (
	"container/heap"
	"sort"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}
func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func batchProcess(tasks [][]int) int {
	sort.Slice(tasks, func(i, j int) bool {
		if tasks[i][0] == tasks[j][0] {
			return tasks[i][1] < tasks[j][1]
		}
		return tasks[i][0] < tasks[j][0]
	})

	minHeap := &MinHeap{}
	heap.Init(minHeap)
	res := 0

	for _, task := range tasks {
		start, end := task[0], task[1]
		for minHeap.Len() > 0 && (*minHeap)[0] <= start {
			heap.Pop(minHeap)
		}
		heap.Push(minHeap, end)
		if minHeap.Len() > res {
			res = minHeap.Len()
		}
	}

	return res
}
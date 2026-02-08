import (
	"container/heap"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MaxHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func findMaximizedCapital(k int, w int, profits []int, capital []int) int {
	n := len(profits)
	projects := make([][2]int, n)
	for i := 0; i < n; i++ {
		projects[i] = [2]int{capital[i], profits[i]}
	}

	sort.Slice(projects, func(i, j int) bool {
		return projects[i][0] < projects[j][0]
	})

	minCapital := &MinHeap{}
	heap.Init(minCapital)
	maxProfit := &MaxHeap{}
	heap.Init(maxProfit)

	i := 0
	for k > 0 {
		for i < n && projects[i][0] <= w {
			heap.Push(maxProfit, projects[i][1])
			i++
		}

		if maxProfit.Len() == 0 {
			break
		}

		w += heap.Pop(maxProfit).(int)
		k--
	}

	return w
}
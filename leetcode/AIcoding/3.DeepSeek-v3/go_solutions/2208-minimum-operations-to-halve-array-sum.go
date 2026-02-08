import (
	"container/heap"
)

type MaxHeap []float64

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(float64))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func halveArray(nums []int) int {
	pq := &MaxHeap{}
	heap.Init(pq)
	sum := 0.0
	for _, num := range nums {
		heap.Push(pq, float64(num))
		sum += float64(num)
	}
	target := sum / 2.0
	operations := 0
	current := 0.0
	for current < target {
		max := heap.Pop(pq).(float64)
		half := max / 2.0
		current += half
		heap.Push(pq, half)
		operations++
	}
	return operations
}
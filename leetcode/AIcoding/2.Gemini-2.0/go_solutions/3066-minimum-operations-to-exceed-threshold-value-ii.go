import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func minOperations(nums []int, k int) int {
	h := &IntHeap{}
	heap.Init(h)
	for _, num := range nums {
		heap.Push(h, num)
	}

	ops := 0
	for h.Len() > 1 && (*h)[0] < k {
		a := heap.Pop(h).(int)
		b := heap.Pop(h).(int)
		heap.Push(h, min(a*2+b, b*2+a))
		ops++
	}

	return ops
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
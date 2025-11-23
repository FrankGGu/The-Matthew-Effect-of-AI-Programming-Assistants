import (
	"container/heap"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
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

func cuttingBamboo(bamboo []int) int {
	h := &IntHeap{}
	heap.Init(h)
	for _, b := range bamboo {
		heap.Push(h, b)
	}

	res := 0
	for h.Len() >= 2 {
		first := heap.Pop(h).(int)
		second := heap.Pop(h).(int)
		product := first * second
		res += product
		heap.Push(h, first+second)
	}

	return res
}
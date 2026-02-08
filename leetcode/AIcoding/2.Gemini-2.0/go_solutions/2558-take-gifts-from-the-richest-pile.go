import "container/heap"

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

func takeGifts(gifts []int, k int) int64 {
	h := &IntHeap{}
	heap.Init(h)
	for _, gift := range gifts {
		heap.Push(h, gift)
	}

	for i := 0; i < k; i++ {
		richest := heap.Pop(h).(int)
		heap.Push(h, int(float64(richest)**0.5))
	}

	var sum int64
	for h.Len() > 0 {
		sum += int64(heap.Pop(h).(int))
	}

	return sum
}
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

func minArrayLength(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	h := &IntHeap{}
	heap.Init(h)

	for _, count := range counts {
		heap.Push(h, count)
	}

	for h.Len() > 1 {
		x := heap.Pop(h).(int)
		y := heap.Pop(h).(int)
		if x > 1 {
			heap.Push(h, x-1)
		}
		if y > 1 {
			heap.Push(h, y-1)
		}
	}

	if h.Len() == 0 {
		return 0
	}
	return heap.Pop(h).(int)
}
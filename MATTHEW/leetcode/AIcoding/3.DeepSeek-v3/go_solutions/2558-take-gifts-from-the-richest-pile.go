import (
	"container/heap"
	"math"
)

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func pickGifts(gifts []int, k int) int64 {
	h := &MaxHeap{}
	heap.Init(h)
	for _, gift := range gifts {
		heap.Push(h, gift)
	}

	for i := 0; i < k; i++ {
		if h.Len() == 0 {
			break
		}
		max := heap.Pop(h).(int)
		remaining := int(math.Sqrt(float64(max)))
		heap.Push(h, remaining)
	}

	var sum int64
	for h.Len() > 0 {
		sum += int64(heap.Pop(h).(int))
	}
	return sum
}
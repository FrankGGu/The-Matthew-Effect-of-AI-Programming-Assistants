import (
	"container/heap"
)

type Apple struct {
	count int
	day   int
}

type MinHeap []Apple

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].day < h[j].day }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Apple))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func eatenApples(apples []int, days []int) int {
	h := &MinHeap{}
	heap.Init(h)
	res := 0
	i := 0
	for i < len(apples) || h.Len() > 0 {
		if i < len(apples) && apples[i] > 0 {
			heap.Push(h, Apple{apples[i], i + days[i]})
		}
		for h.Len() > 0 && (*h)[0].day <= i {
			heap.Pop(h)
		}
		if h.Len() > 0 {
			res++
			(*h)[0].count--
			if (*h)[0].count == 0 {
				heap.Pop(h)
			}
		}
		i++
	}
	return res
}
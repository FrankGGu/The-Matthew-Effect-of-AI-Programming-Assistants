import (
	"container/heap"
)

type MaxHeap [][]int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return (h[i][0]+1)*h[j][1] > (h[j][0]+1)*h[i][1] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}
func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func maxAverageRatio(classes [][]int, extraStudents int) float64 {
	h := &MaxHeap{}
	heap.Init(h)
	for _, c := range classes {
		heap.Push(h, []int{c[0], c[1]})
	}

	for extraStudents > 0 {
		c := heap.Pop(h).([]int)
		c[0]++
		c[1]++
		heap.Push(h, c)
		extraStudents--
	}

	sum := 0.0
	for h.Len() > 0 {
		c := heap.Pop(h).([]int)
		sum += float64(c[0]) / float64(c[1])
	}
	return sum / float64(len(classes))
}
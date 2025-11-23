import (
	"container/heap"
	"sort"
)

type Point struct {
	X int
	Y int
}

type MaxHeap []Point

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h.dist(i) > h.dist(j) }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Point))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func (h MaxHeap) dist(i int) int {
	return h[i].X*h[i].X + h[i].Y*h[i].Y
}

func kClosest(points [][]int, k int) [][]int {
	h := &MaxHeap{}
	heap.Init(h)

	for _, p := range points {
		point := Point{X: p[0], Y: p[1]}
		if h.Len() < k {
			heap.Push(h, point)
		} else {
			if h.dist(0) > point.X*point.X+point.Y*point.Y {
				heap.Pop(h)
				heap.Push(h, point)
			}
		}
	}

	result := [][]int{}
	for h.Len() > 0 {
		p := heap.Pop(h).(Point)
		result = append(result, []int{p.X, p.Y})
	}

	return result
}
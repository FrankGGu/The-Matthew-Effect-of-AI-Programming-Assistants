import "container/heap"

type Pair struct {
	Val int
	Idx int
}

type MaxHeap []Pair

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].Val > h[j].Val }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Pair))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func findMaxValueOfEquation(points [][]int, k int) int {
	pq := &MaxHeap{}
	heap.Init(pq)
	ans := -1 << 60
	for _, p := range points {
		x, y := p[0], p[1]
		for pq.Len() > 0 && x-pq.([]Pair)[0].Idx > k {
			heap.Pop(pq)
		}
		if pq.Len() > 0 {
			ans = max(ans, x+y+pq.([]Pair)[0].Val)
		}
		heap.Push(pq, Pair{Val: y - x, Idx: x})
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
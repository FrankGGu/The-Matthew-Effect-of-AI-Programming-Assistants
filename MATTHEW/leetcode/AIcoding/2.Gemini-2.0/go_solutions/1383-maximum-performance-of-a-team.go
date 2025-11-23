import (
	"container/heap"
	"sort"
)

type Pair struct {
	Speed int
	Efficiency int
}

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

func maxPerformance(n int, speed []int, efficiency []int, k int) int {
	pairs := make([]Pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = Pair{speed[i], efficiency[i]}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].Efficiency > pairs[j].Efficiency
	})

	h := &IntHeap{}
	heap.Init(h)
	sum := 0
	ans := 0
	for i := 0; i < n; i++ {
		heap.Push(h, pairs[i].Speed)
		sum += pairs[i].Speed
		if h.Len() > k {
			sum -= heap.Pop(h).(int)
		}
		ans = max(ans, sum * pairs[i].Efficiency)
	}

	return ans % 1000000007
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
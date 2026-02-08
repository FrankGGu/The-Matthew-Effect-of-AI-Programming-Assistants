import (
	"container/heap"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func sum(x int, n int) int {
	if x >= n {
		return n * x - n*(n-1)/2
	}
	return 0
}

func findNumDistinctColors(balls []int, orders int) int {
	h := &IntHeap{}
	heap.Init(h)
	for i := 0; i < len(balls); i++ {
		heap.Push(h, balls[i])
	}
	ans := 0
	MOD := 1000000007
	for orders > 0 {
		x := heap.Pop(h).(int)
		ans = (ans + x) % MOD
		orders--
		x--
		if x > 0 {
			heap.Push(h, x)
		}
	}
	return ans
}

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
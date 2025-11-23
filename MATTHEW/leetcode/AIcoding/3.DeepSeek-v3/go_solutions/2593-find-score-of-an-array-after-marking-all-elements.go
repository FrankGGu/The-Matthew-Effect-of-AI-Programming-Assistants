import (
	"container/heap"
)

type MinHeap [][2]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] || (h[i][0] == h[j][0] && h[i][1] < h[j][1]) }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.([2]int)) }
func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func findScore(nums []int) int64 {
	n := len(nums)
	marked := make([]bool, n)
	h := &MinHeap{}
	heap.Init(h)
	for i, num := range nums {
		heap.Push(h, [2]int{num, i})
	}
	var score int64 = 0
	for h.Len() > 0 {
		top := heap.Pop(h).([2]int)
		num, i := top[0], top[1]
		if marked[i] {
			continue
		}
		score += int64(num)
		marked[i] = true
		if i > 0 {
			marked[i-1] = true
		}
		if i < n-1 {
			marked[i+1] = true
		}
	}
	return score
}
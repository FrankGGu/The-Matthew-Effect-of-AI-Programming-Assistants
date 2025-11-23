import (
	"container/heap"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func magicTower(nums []int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	if sum < 0 {
		return -1
	}

	h := &MinHeap{}
	heap.Init(h)
	curr := 1
	res := 0

	for _, num := range nums {
		curr += num
		heap.Push(h, num)
		if curr <= 0 {
			min := heap.Pop(h).(int)
			curr -= min
			res++
		}
	}
	return res
}
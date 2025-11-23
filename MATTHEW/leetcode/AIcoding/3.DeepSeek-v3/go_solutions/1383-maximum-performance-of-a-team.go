import (
	"container/heap"
	"sort"
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

func maxPerformance(n int, speed []int, efficiency []int, k int) int {
	engineers := make([][2]int, n)
	for i := 0; i < n; i++ {
		engineers[i] = [2]int{efficiency[i], speed[i]}
	}
	sort.Slice(engineers, func(i, j int) bool {
		return engineers[i][0] > engineers[j][0]
	})

	minHeap := &MinHeap{}
	heap.Init(minHeap)
	sumSpeed := 0
	res := 0
	for _, eng := range engineers {
		eff, spd := eng[0], eng[1]
		heap.Push(minHeap, spd)
		sumSpeed += spd
		if minHeap.Len() > k {
			sumSpeed -= heap.Pop(minHeap).(int)
		}
		current := sumSpeed * eff
		if current > res {
			res = current
		}
	}
	return res % (1e9 + 7)
}
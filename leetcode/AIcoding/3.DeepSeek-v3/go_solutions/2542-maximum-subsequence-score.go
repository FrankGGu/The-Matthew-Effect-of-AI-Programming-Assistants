import (
	"container/heap"
	"sort"
)

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

func maxScore(nums1 []int, nums2 []int, k int) int64 {
	n := len(nums1)
	pairs := make([][2]int, n)
	for i := 0; i < n; i++ {
		pairs[i] = [2]int{nums1[i], nums2[i]}
	}
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][1] > pairs[j][1]
	})

	h := &IntHeap{}
	heap.Init(h)
	sum := 0
	var res int64 = 0

	for i := 0; i < k; i++ {
		sum += pairs[i][0]
		heap.Push(h, pairs[i][0])
	}
	res = int64(sum) * int64(pairs[k-1][1])

	for i := k; i < n; i++ {
		sum += pairs[i][0] - heap.Pop(h).(int)
		heap.Push(h, pairs[i][0])
		current := int64(sum) * int64(pairs[i][1])
		if current > res {
			res = current
		}
	}

	return res
}
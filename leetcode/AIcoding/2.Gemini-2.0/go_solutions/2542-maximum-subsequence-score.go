import (
	"container/heap"
	"sort"
)

type Pair struct {
	Num1 int
	Num2 int
}

func maxScore(nums1 []int, nums2 []int, k int) int64 {
	pairs := make([]Pair, len(nums1))
	for i := range nums1 {
		pairs[i] = Pair{nums1[i], nums2[i]}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].Num2 > pairs[j].Num2
	})

	h := &IntHeap{}
	heap.Init(h)
	sum := 0
	for i := 0; i < k; i++ {
		sum += pairs[i].Num1
		heap.Push(h, pairs[i].Num1)
	}

	ans := int64(sum * pairs[k-1].Num2)

	for i := k; i < len(nums1); i++ {
		sum += pairs[i].Num1 - heap.Pop(h).(int)
		heap.Push(h, pairs[i].Num1)
		ans = max(ans, int64(sum*pairs[i].Num2))
	}

	return ans
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
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
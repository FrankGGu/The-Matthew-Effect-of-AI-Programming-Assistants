import (
	"container/heap"
)

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

func minSumSquareDiff(nums1 []int, nums2 []int, k1 int, k2 int) int64 {
	n := len(nums1)
	diffs := make([]int, n)
	for i := 0; i < n; i++ {
		diffs[i] = abs(nums1[i] - nums2[i])
	}

	h := &IntHeap{}
	heap.Init(h)
	for _, diff := range diffs {
		heap.Push(h, diff)
	}

	k := k1 + k2
	for k > 0 {
		top := heap.Pop(h).(int)
		if top == 0 {
			break
		}
		heap.Push(h, top-1)
		k--
	}

	var ans int64 = 0
	for h.Len() > 0 {
		val := heap.Pop(h).(int)
		ans += int64(val) * int64(val)
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
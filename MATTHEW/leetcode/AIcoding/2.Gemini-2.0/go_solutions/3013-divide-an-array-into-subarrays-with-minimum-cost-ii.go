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

func minCost(nums []int, k int, dist int) int64 {
	n := len(nums)
	pre := make([]int64, n+1)
	for i := 1; i <= n; i++ {
		pre[i] = pre[i-1] + int64(nums[i-1])
	}

	res := int64(1e18)
	for i := dist; i < n; i++ {
		arr := nums[1 : i+1]
		sort.Ints(arr)
		cost := int64(0)
		for j := 0; j < k; j++ {
			cost += int64(arr[j])
		}
		res = min(res, cost+int64(nums[0]))
	}

	return res
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}
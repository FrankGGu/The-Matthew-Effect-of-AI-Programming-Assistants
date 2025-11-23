import (
	"container/heap"
	"sort"
)

func minimumDifference(nums []int) int {
	n := len(nums) / 3
	sum1 := 0
	pq1 := &IntHeap{}
	heap.Init(pq1)
	for i := 0; i < n; i++ {
		sum1 += nums[i]
		heap.Push(pq1, nums[i])
	}
	left := make([]int, n+1)
	left[0] = sum1
	for i := n; i < 2*n; i++ {
		if nums[i] > (*pq1)[0] {
			sum1 += nums[i] - heap.Pop(pq1).(int)
			heap.Push(pq1, nums[i])
		}
		left[i-n+1] = sum1
	}

	sum2 := 0
	pq2 := &IntHeap{}
	heap.Init(pq2)
	for i := 3*n - 1; i >= 2*n; i-- {
		sum2 += nums[i]
		heap.Push(pq2, -nums[i])
	}
	right := make([]int, n+1)
	right[0] = sum2
	for i := 2*n - 1; i >= n; i-- {
		if -nums[i] > (*pq2)[0] {
			sum2 += nums[i] + heap.Pop(pq2).(int)
			heap.Push(pq2, -nums[i])
		}
		right[2*n-i] = sum2
	}
	sort.Slice(right, func(i, j int) bool {
		return i > j
	})

	ans := left[0] - right[0]
	for i := 1; i <= n; i++ {
		ans = min(ans, left[i]-right[i])
	}
	return ans
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

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
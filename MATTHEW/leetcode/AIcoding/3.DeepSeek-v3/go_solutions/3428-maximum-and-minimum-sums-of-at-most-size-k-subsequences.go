import (
	"container/heap"
	"sort"
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

func maxSumSubsequence(nums []int, k int) int64 {
	sort.Ints(nums)
	n := len(nums)
	var sum int64 = 0
	for i := n - 1; i >= n-k; i-- {
		sum += int64(nums[i])
	}
	return sum
}

func minSumSubsequence(nums []int, k int) int64 {
	sort.Ints(nums)
	var sum int64 = 0
	for i := 0; i < k; i++ {
		sum += int64(nums[i])
	}
	return sum
}

func kSum(nums []int, k int) int64 {
	n := len(nums)
	var total int64 = 0
	absNums := make([]int, n)
	for i := 0; i < n; i++ {
		if nums[i] > 0 {
			total += int64(nums[i])
		} else {
			nums[i] = -nums[i]
		}
		absNums[i] = nums[i]
	}
	sort.Ints(absNums)

	h := &IntHeap{}
	heap.Init(h)
	heap.Push(h, 0)

	var res int64 = 0
	for i := 0; i < k; i++ {
		curr := heap.Pop(h).(int)
		res = int64(curr)
		if i == k-1 {
			break
		}
		for j := 0; j < n; j++ {
			if len(*h) < k || curr+absNums[j] < (*h)[0] {
				heap.Push(h, curr+absNums[j])
				if len(*h) > k {
					heap.Pop(h)
				}
			} else {
				break
			}
		}
	}
	return total - res
}
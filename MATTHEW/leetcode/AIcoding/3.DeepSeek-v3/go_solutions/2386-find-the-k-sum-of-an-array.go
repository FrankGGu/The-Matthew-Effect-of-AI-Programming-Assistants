import (
	"container/heap"
	"sort"
)

type MaxHeap [][]int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i][0] > h[j][0] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func kSum(nums []int, k int) int64 {
	var maxSum int64 = 0
	n := len(nums)
	for i := 0; i < n; i++ {
		if nums[i] > 0 {
			maxSum += int64(nums[i])
		} else {
			nums[i] = -nums[i]
		}
	}
	sort.Ints(nums)

	h := &MaxHeap{}
	heap.Init(h)
	heap.Push(h, []int{0, 0})

	for i := 1; i < k; i++ {
		curr := heap.Pop(h).([]int)
		sum := curr[0]
		pos := curr[1]
		if pos < n {
			heap.Push(h, []int{sum + nums[pos], pos + 1})
			if pos > 0 {
				heap.Push(h, []int{sum + nums[pos] - nums[pos-1], pos + 1})
			}
		}
	}
	return maxSum - int64((*h)[0][0])
}
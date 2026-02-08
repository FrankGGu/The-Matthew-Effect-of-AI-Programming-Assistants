import (
	"container/heap"
	"math"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MinHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *MaxHeap) Push(x interface{}) { *h = append(*h, x.(int)) }
func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[:n-1]
	return x
}

func minimumDifference(nums []int) int64 {
	n := len(nums) / 3
	minLeft := make([]int64, 3*n)
	maxRight := make([]int64, 3*n)

	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)
	sum := int64(0)
	for i := 0; i < 2*n; i++ {
		heap.Push(maxHeap, nums[i])
		sum += int64(nums[i])
		if maxHeap.Len() > n {
			val := heap.Pop(maxHeap).(int)
			sum -= int64(val)
		}
		if i >= n-1 {
			minLeft[i] = sum
		}
	}

	minHeap := &MinHeap{}
	heap.Init(minHeap)
	sum = int64(0)
	for i := 3*n - 1; i >= n; i-- {
		heap.Push(minHeap, nums[i])
		sum += int64(nums[i])
		if minHeap.Len() > n {
			val := heap.Pop(minHeap).(int)
			sum -= int64(val)
		}
		if i <= 2*n {
			maxRight[i] = sum
		}
	}

	res := int64(math.MaxInt64)
	for i := n - 1; i < 2*n; i++ {
		diff := minLeft[i] - maxRight[i+1]
		if diff < res {
			res = diff
		}
	}
	return res
}
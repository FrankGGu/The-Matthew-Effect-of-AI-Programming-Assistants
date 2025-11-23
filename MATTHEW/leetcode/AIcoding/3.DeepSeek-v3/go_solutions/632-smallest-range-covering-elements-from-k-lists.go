import (
	"container/heap"
	"math"
)

type MinHeap [][]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.([]int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func smallestRange(nums [][]int) []int {
	minHeap := &MinHeap{}
	heap.Init(minHeap)
	maxVal := math.MinInt32
	minRange := math.MaxInt32
	res := make([]int, 2)

	for i := 0; i < len(nums); i++ {
		heap.Push(minHeap, []int{nums[i][0], i, 0})
		if nums[i][0] > maxVal {
			maxVal = nums[i][0]
		}
	}

	for {
		current := heap.Pop(minHeap).([]int)
		currentVal, listIdx, elementIdx := current[0], current[1], current[2]
		if maxVal-currentVal < minRange {
			minRange = maxVal - currentVal
			res[0] = currentVal
			res[1] = maxVal
		}

		if elementIdx+1 == len(nums[listIdx]) {
			break
		}

		nextVal := nums[listIdx][elementIdx+1]
		heap.Push(minHeap, []int{nextVal, listIdx, elementIdx + 1})
		if nextVal > maxVal {
			maxVal = nextVal
		}
	}

	return res
}
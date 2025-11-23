import (
	"container/heap"
	"math"
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

func minimumDeviation(nums []int) int {
	h := &IntHeap{}
	heap.Init(h)
	minVal := math.MaxInt32
	for _, num := range nums {
		if num%2 == 1 {
			num *= 2
		}
		heap.Push(h, num)
		if num < minVal {
			minVal = num
		}
	}
	minDeviation := math.MaxInt32
	for {
		maxVal := heap.Pop(h).(int)
		currentDeviation := maxVal - minVal
		if currentDeviation < minDeviation {
			minDeviation = currentDeviation
		}
		if maxVal%2 == 0 {
			maxVal /= 2
			if maxVal < minVal {
				minVal = maxVal
			}
			heap.Push(h, maxVal)
		} else {
			break
		}
	}
	return minDeviation
}
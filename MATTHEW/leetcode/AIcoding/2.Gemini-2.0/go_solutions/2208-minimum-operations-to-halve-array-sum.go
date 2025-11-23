import (
	"container/heap"
	"math"
)

type Float64Heap []float64

func (h Float64Heap) Len() int           { return len(h) }
func (h Float64Heap) Less(i, j int) bool { return h[i] > h[j] }
func (h Float64Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Float64Heap) Push(x interface{}) {
	*h = append(*h, x.(float64))
}

func (h *Float64Heap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func halveArray(nums []int) int {
	sum := 0.0
	h := &Float64Heap{}
	heap.Init(h)

	for _, num := range nums {
		f := float64(num)
		sum += f
		heap.Push(h, f)
	}

	target := sum / 2.0
	ops := 0
	currSum := 0.0

	for currSum < target {
		val := heap.Pop(h).(float64)
		currSum += val / 2.0
		heap.Push(h, val/2.0)
		ops++
	}

	return ops
}
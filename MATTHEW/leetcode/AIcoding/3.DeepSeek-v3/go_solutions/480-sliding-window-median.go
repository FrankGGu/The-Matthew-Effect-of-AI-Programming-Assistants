import (
	"container/heap"
	"sort"
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
	*h = old[0 : n-1]
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
	*h = old[0 : n-1]
	return x
}

type MedianFinder struct {
	maxHeap *MaxHeap
	minHeap *MinHeap
}

func Constructor() MedianFinder {
	max := &MaxHeap{}
	min := &MinHeap{}
	heap.Init(max)
	heap.Init(min)
	return MedianFinder{max, min}
}

func (mf *MedianFinder) AddNum(num int) {
	if mf.maxHeap.Len() == 0 || num <= (*mf.maxHeap)[0] {
		heap.Push(mf.maxHeap, num)
	} else {
		heap.Push(mf.minHeap, num)
	}

	if mf.maxHeap.Len() > mf.minHeap.Len()+1 {
		heap.Push(mf.minHeap, heap.Pop(mf.maxHeap))
	} else if mf.minHeap.Len() > mf.maxHeap.Len() {
		heap.Push(mf.maxHeap, heap.Pop(mf.minHeap))
	}
}

func (mf *MedianFinder) FindMedian() float64 {
	if mf.maxHeap.Len() == mf.minHeap.Len() {
		return float64((*mf.maxHeap)[0]+(*mf.minHeap)[0]) / 2.0
	}
	return float64((*mf.maxHeap)[0])
}

func medianSlidingWindow(nums []int, k int) []float64 {
	mf := Constructor()
	result := make([]float64, 0, len(nums)-k+1)
	window := make([]int, 0, k)

	for i := 0; i < len(nums); i++ {
		mf.AddNum(nums[i])
		window = append(window, nums[i])

		if len(window) == k {
			result = append(result, mf.FindMedian())
			toRemove := window[0]
			window = window[1:]

			index := sort.SearchInts(*mf.maxHeap, toRemove)
			if index < mf.maxHeap.Len() && (*mf.maxHeap)[index] == toRemove {
				heap.Remove(mf.maxHeap, index)
			} else {
				index = sort.SearchInts(*mf.minHeap, toRemove)
				heap.Remove(mf.minHeap, index)
			}

			if mf.maxHeap.Len() > mf.minHeap.Len()+1 {
				heap.Push(mf.minHeap, heap.Pop(mf.maxHeap))
			} else if mf.minHeap.Len() > mf.maxHeap.Len() {
				heap.Push(mf.maxHeap, heap.Pop(mf.minHeap))
			}
		}
	}

	return result
}
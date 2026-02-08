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

type MaxHeap IntHeap

func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }

type MedianFinder struct {
	small MaxHeap
	large IntHeap
}

func Constructor() MedianFinder {
	return MedianFinder{}
}

func (mf *MedianFinder) AddNum(num int) {
	heap.Push(&mf.small, num)
	heap.Push(&mf.large, heap.Pop(&mf.small))
	if mf.large.Len() > mf.small.Len() {
		heap.Push(&mf.small, heap.Pop(&mf.large))
	}
}

func (mf *MedianFinder) FindMedian() float64 {
	if mf.small.Len() > mf.large.Len() {
		return float64(mf.small[0])
	}
	return float64(mf.small[0]+mf.large[0]) / 2.0
}

func medianSlidingWindow(nums []int, k int) []float64 {
	result := make([]float64, 0)
	window := make([]int, k)
	for i := 0; i < k; i++ {
		window[i] = nums[i]
	}
	sort.Ints(window)
	mf := MedianFinder{}
	for i := 0; i < k; i++ {
		mf.AddNum(window[i])
	}
	result = append(result, mf.FindMedian())

	for i := k; i < len(nums); i++ {
		idx := sort.SearchInts(window, nums[i-k])
		window = append(window[:idx], window[idx+1:]...)
		idx = sort.Search(len(window), func(j int) bool { return window[j] >= nums[i] })
		window = append(window[:idx], append([]int{nums[i]}, window[idx:]...)...)

		mf = MedianFinder{}
		for j := 0; j < k; j++ {
			mf.AddNum(window[j])
		}
		result = append(result, mf.FindMedian())
	}
	return result
}
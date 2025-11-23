import "container/heap"

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

type MedianFinder struct {
	maxHeap IntHeap // 小于等于中位数的数，大顶堆
	minHeap IntHeap // 大于等于中位数的数，小顶堆
}

func Constructor() MedianFinder {
	return MedianFinder{
		maxHeap: IntHeap{},
		minHeap: IntHeap{},
	}
}

func (this *MedianFinder) AddNum(num int) {
	heap.Push(&this.maxHeap, num)
	heap.Init(&this.maxHeap)
	heap.Push(&this.minHeap, heap.Pop(&this.maxHeap))
	heap.Init(&this.minHeap)
	if this.minHeap.Len() > this.maxHeap.Len() {
		heap.Push(&this.maxHeap, heap.Pop(&this.minHeap))
		heap.Init(&this.maxHeap)
	}
}

func (this *MedianFinder) FindMedian() float64 {
	if this.maxHeap.Len() == this.minHeap.Len() {
		if this.maxHeap.Len() == 0 {
			return 0.0
		}
		return float64(this.maxHeap[0]+this.minHeap[0]) / 2.0
	} else {
		return float64(this.maxHeap[0])
	}
}
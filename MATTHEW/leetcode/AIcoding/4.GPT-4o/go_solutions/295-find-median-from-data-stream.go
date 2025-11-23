type MedianFinder struct {
    maxHeap *heap.IntHeap
    minHeap *heap.IntHeap
}

func Constructor() MedianFinder {
    return MedianFinder{
        maxHeap: &heap.IntHeap{},
        minHeap: &heap.IntHeap{},
    }
}

func (this *MedianFinder) AddNum(num int) {
    heap.Push(this.maxHeap, -num)
    heap.Push(this.minHeap, -heap.Pop(this.maxHeap).(int))
    if this.minHeap.Len() > this.maxHeap.Len() {
        heap.Push(this.maxHeap, -heap.Pop(this.minHeap).(int))
    }
}

func (this *MedianFinder) FindMedian() float64 {
    if this.maxHeap.Len() > this.minHeap.Len() {
        return float64(-(*this.maxHeap)[0])
    }
    return float64(-(*this.maxHeap)[0]+(*this.minHeap)[0]) / 2.0
}
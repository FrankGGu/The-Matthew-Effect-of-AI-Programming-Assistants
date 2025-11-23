import (
    "container/heap"
    "sort"
)

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func medianSlidingWindow(nums []int, k int) []float64 {
    maxHeap := &MaxHeap{}
    minHeap := &MinHeap{}
    result := []float64{}

    for i := 0; i < len(nums); i++ {
        if maxHeap.Len() == 0 || nums[i] <= (*maxHeap)[0] {
            heap.Push(maxHeap, nums[i])
        } else {
            heap.Push(minHeap, nums[i])
        }

        if maxHeap.Len() > minHeap.Len()+1 {
            heap.Push(minHeap, heap.Pop(maxHeap))
        } else if minHeap.Len() > maxHeap.Len() {
            heap.Push(maxHeap, heap.Pop(minHeap))
        }

        if i >= k-1 {
            if maxHeap.Len() > minHeap.Len() {
                result = append(result, float64((*maxHeap)[0]))
            } else {
                result = append(result, float64((*maxHeap)[0]+(*minHeap)[0])/2.0)
            }

            outgoing := nums[i-k+1]
            if outgoing <= (*maxHeap)[0] {
                heap.Remove(maxHeap, findIndex(*maxHeap, outgoing))
            } else {
                heap.Remove(minHeap, findIndex(*minHeap, outgoing))
            }

            if maxHeap.Len() > minHeap.Len()+1 {
                heap.Push(minHeap, heap.Pop(maxHeap))
            } else if minHeap.Len() > maxHeap.Len() {
                heap.Push(maxHeap, heap.Pop(minHeap))
            }
        }
    }
    return result
}

func findIndex(h interface{}, val int) int {
    for i := 0; i < reflect.ValueOf(h).Len(); i++ {
        if reflect.ValueOf(h).Index(i).Interface().(int) == val {
            return i
        }
    }
    return -1
}
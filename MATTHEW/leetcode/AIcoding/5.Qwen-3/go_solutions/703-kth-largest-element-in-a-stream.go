package main

type KthLargest struct {
    nums []int
    k    int
}

func Constructor(k int, nums []int) KthLargest {
    heap.Init(&minHeap{nums})
    for len(nums) > k {
        heap.Pop(&minHeap{nums})
    }
    return KthLargest{nums, k}
}

func (this *KthLargest) Add(val int) int {
    if len(this.nums) < this.k {
        heap.Push(&minHeap{this.nums}, val)
    } else if val > this.nums[0] {
        heap.Pop(&minHeap{this.nums})
        heap.Push(&minHeap{this.nums}, val)
    }
    return this.nums[0]
}

type minHeap struct {
    data []int
}

func (h minHeap) Len() int           { return len(h.data) }
func (h minHeap) Less(i, j int) bool { return h.data[i] < h.data[j] }
func (h minHeap) Swap(i, j int)      { h.data[i], h.data[j] = h.data[j], h.data[i] }

func (h *minHeap) Push(x interface{}) {
    h.data = append(h.data, x.(int))
}

func (h *minHeap) Pop() interface{} {
    old := h.data
    n := len(old)
    x := old[n-1]
    h.data = old[0 : n-1]
    return x
}
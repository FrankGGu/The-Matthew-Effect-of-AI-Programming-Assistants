type KthLargest struct {
    minHeap []int
    k       int
}

func Constructor(k int, nums []int) KthLargest {
    kl := KthLargest{k: k}
    for _, num := range nums {
        kl.Add(num)
    }
    return kl
}

func (this *KthLargest) Add(val int) int {
    this.minHeap = append(this.minHeap, val)
    if len(this.minHeap) > this.k {
        this.minHeap = this.minHeap[1:]
        sort.Ints(this.minHeap)
    }
    sort.Ints(this.minHeap)
    return this.minHeap[0]
}
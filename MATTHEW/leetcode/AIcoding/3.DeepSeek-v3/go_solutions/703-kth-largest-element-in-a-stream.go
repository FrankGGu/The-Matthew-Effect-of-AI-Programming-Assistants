type KthLargest struct {
    k int
    heap *IntHeap
}

func Constructor(k int, nums []int) KthLargest {
    h := &IntHeap{}
    heap.Init(h)
    for _, num := range nums {
        heap.Push(h, num)
        if h.Len() > k {
            heap.Pop(h)
        }
    }
    return KthLargest{k: k, heap: h}
}

func (this *KthLargest) Add(val int) int {
    heap.Push(this.heap, val)
    if this.heap.Len() > this.k {
        heap.Pop(this.heap)
    }
    return (*this.heap)[0]
}

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
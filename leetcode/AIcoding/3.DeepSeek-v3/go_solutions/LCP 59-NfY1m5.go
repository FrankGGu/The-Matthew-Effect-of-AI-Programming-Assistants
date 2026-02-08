func minBuildTime(blocks []int, split int) int {
    heap := &IntHeap{}
    for _, block := range blocks {
        heap.Push(block)
    }
    for heap.Len() > 1 {
        a := heap.Pop().(int)
        b := heap.Pop().(int)
        heap.Push(b + split)
    }
    return heap.Pop().(int)
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
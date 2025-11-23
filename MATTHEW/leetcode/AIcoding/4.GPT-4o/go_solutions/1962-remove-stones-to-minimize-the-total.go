func minStoneSum(piles []int, k int) int {
    maxHeap := &IntHeap{}
    heap.Init(maxHeap)

    for _, pile := range piles {
        heap.Push(maxHeap, pile)
    }

    for i := 0; i < k; i++ {
        largest := heap.Pop(maxHeap).(int)
        largest -= largest / 2
        heap.Push(maxHeap, largest)
    }

    total := 0
    for maxHeap.Len() > 0 {
        total += heap.Pop(maxHeap).(int)
    }

    return total
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
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
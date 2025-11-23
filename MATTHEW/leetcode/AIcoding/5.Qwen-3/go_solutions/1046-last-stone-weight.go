package main

func lastStoneWeight(stones []int) int {
    h := &MaxHeap{}
    for _, s := range stones {
        heap.Push(h, s)
    }
    for h.Len() > 1 {
        x := heap.Pop(h).(int)
        y := heap.Pop(h).(int)
        if x > y {
            heap.Push(h, x-y)
        }
    }
    if h.Len() == 0 {
        return 0
    }
    return heap.Pop(h).(int)
}

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
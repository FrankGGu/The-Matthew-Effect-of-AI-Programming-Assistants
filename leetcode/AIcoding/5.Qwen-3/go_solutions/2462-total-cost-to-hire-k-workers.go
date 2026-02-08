package main

func totalCostToHireKWorkers(costs []int, k int) int {
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

    left := &IntHeap{}
    right := &IntHeap{}

    for _, c := range costs {
        heap.Push(left, c)
    }

    var result int

    for i := 0; i < k; i++ {
        if left.Len() == 0 {
            result += heap.Pop(right).(int)
        } else if right.Len() == 0 {
            result += heap.Pop(left).(int)
        } else {
            if (*left)[0] <= (*right)[0] {
                result += heap.Pop(left).(int)
            } else {
                result += heap.Pop(right).(int)
            }
        }
    }

    return result
}
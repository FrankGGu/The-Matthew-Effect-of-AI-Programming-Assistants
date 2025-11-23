import (
    "container/heap"
    "sort"
)

type Engineer struct {
    speed int
    efficiency int
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

func maxPerformance(n int, speed []int, efficiency []int, k int) int {
    engineers := make([]Engineer, n)
    for i := 0; i < n; i++ {
        engineers[i] = Engineer{speed: speed[i], efficiency: efficiency[i]}
    }

    sort.Slice(engineers, func(i, j int) bool {
        return engineers[i].efficiency > engineers[j].efficiency
    })

    h := &MaxHeap{}
    heap.Init(h)

    var totalSpeed int
    maxPerformance := 0
    mod := 1_000_000_007

    for _, engineer := range engineers {
        if h.Len() == k {
            totalSpeed -= heap.Pop(h).(int)
        }
        totalSpeed += engineer.speed
        heap.Push(h, engineer.speed)
        maxPerformance = max(maxPerformance, totalSpeed * engineer.efficiency)
    }

    return maxPerformance % mod
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
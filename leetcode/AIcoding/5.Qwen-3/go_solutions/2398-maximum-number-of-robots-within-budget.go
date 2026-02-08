package main

func maximumRobots(cost []int, efficiency []int, budget int) int {
    n := len(cost)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{cost[i], efficiency[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0] < pairs[j][0]
    })
    maxRobots := 0
    totalCost := 0
    heap := &IntHeap{}
    for i := 0; i < n; i++ {
        totalCost += pairs[i][0]
        heap.Push(heap, pairs[i][1])
        if totalCost > budget {
            totalCost -= pairs[i][0]
            heap.Pop(heap)
        }
        maxRobots = max(maxRobots, heap.Len())
    }
    return maxRobots
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

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
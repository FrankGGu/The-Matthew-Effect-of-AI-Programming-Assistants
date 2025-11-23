package main

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    if n == 0 {
        return 0
    }
    minHeap := &MinHeap{}
    visited := make([]bool, n)
    totalCost := 0
    // Start with the first point
    for i := 1; i < n; i++ {
        cost := abs(points[0][0]-points[i][0]) + abs(points[0][1]-points[i][1])
        heap.Push(minHeap, Edge{cost, i})
    }
    visited[0] = true
    for minHeap.Len() > 0 {
        edge := heap.Pop(minHeap).(Edge)
        if visited[edge.to] {
            continue
        }
        totalCost += edge.cost
        visited[edge.to] = true
        for i := 0; i < n; i++ {
            if !visited[i] {
                cost := abs(points[edge.to][0]-points[i][0]) + abs(points[edge.to][1]-points[i][1])
                heap.Push(minHeap, Edge{cost, i})
            }
        }
    }
    return totalCost
}

type Edge struct {
    cost int
    to   int
}

type MinHeap []Edge

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].cost < h[j].cost }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
    *h = append(*h, x.(Edge))
}

func (h *MinHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
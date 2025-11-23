import (
    "container/heap"
)

type Edge struct {
    u, v, cost int
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

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    if n == 1 {
        return 0
    }

    visited := make([]bool, n)
    h := &MinHeap{}
    heap.Init(h)

    visited[0] = true
    for i := 1; i < n; i++ {
        cost := abs(points[0][0]-points[i][0]) + abs(points[0][1]-points[i][1])
        heap.Push(h, Edge{0, i, cost})
    }

    res := 0
    edgesUsed := 0

    for edgesUsed < n-1 {
        edge := heap.Pop(h).(Edge)
        if visited[edge.v] {
            continue
        }
        res += edge.cost
        visited[edge.v] = true
        edgesUsed++

        for i := 0; i < n; i++ {
            if !visited[i] {
                cost := abs(points[edge.v][0]-points[i][0]) + abs(points[edge.v][1]-points[i][1])
                heap.Push(h, Edge{edge.v, i, cost})
            }
        }
    }

    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
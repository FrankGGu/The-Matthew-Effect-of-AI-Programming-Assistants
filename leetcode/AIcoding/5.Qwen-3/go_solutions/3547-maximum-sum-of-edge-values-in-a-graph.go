package main

func maxEdgeSum(n int, edges [][]int, k int) int {
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    maxHeap := &MaxHeap{}
    for i := 0; i < n; i++ {
        if len(graph[i]) >= 1 {
            heap.Push(maxHeap, []int{i, 0})
        }
    }

    res := 0
    visited := make([]bool, n)
    for k > 0 && maxHeap.Len() > 0 {
        curr := heap.Pop(maxHeap).([]int)
        node, idx := curr[0], curr[1]
        if visited[node] {
            continue
        }
        res += node
        visited[node] = true
        k--
        for i := idx; i < len(graph[node]); i++ {
            neighbor := graph[node][i]
            if !visited[neighbor] {
                heap.Push(maxHeap, []int{neighbor, 0})
            }
        }
    }

    return res
}

type MaxHeap [][]int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i][0] > h[j][0] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
    *h = append(*h, x.([]int))
}

func (h *MaxHeap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}
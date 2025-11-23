package main

func countRestrictedPaths(graph [][]int) int {
    const MOD = 1000000007
    n := len(graph)
    degree := make([]int, n)
    for i := 0; i < n; i++ {
        degree[i] = len(graph[i])
    }
    type pair struct {
        node int
        dist int
    }
    h := &Heap{}
    for i := 0; i < n; i++ {
        heap.Push(h, pair{i, 0})
    }
    dist := make([]int, n)
    visited := make([]bool, n)
    for h.Len() > 0 {
        p := heap.Pop(h).(pair)
        if visited[p.node] {
            continue
        }
        visited[p.node] = true
        for _, neighbor := range graph[p.node] {
            if !visited[neighbor] {
                dist[neighbor] = min(dist[neighbor], dist[p.node]+1)
                heap.Push(h, pair{neighbor, dist[neighbor]})
            }
        }
    }
    dp := make([]int, n)
    dp[n-1] = 1
    nodes := make([]int, n)
    for i := 0; i < n; i++ {
        nodes[i] = i
    }
    sort.Slice(nodes, func(i, j int) bool {
        return dist[nodes[i]] < dist[nodes[j]]
    })
    for _, u := range nodes {
        if u == n-1 {
            continue
        }
        for _, v := range graph[u] {
            if dist[v] > dist[u] {
                dp[v] = (dp[v] + dp[u]) % MOD
            }
        }
    }
    return dp[0]
}

type Heap []pair

func (h Heap) Len() int           { return len(h) }
func (h Heap) Less(i, j int) bool { return h[i].dist < h[j].dist }
func (h Heap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Heap) Push(x interface{}) {
    *h = append(*h, x.(pair))
}

func (h *Heap) Pop() interface{} {
    old := *h
    n := len(old)
    x := old[n-1]
    *h = old[0 : n-1]
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
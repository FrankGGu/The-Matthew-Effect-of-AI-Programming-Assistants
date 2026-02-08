package main

func minCost(graph [][]int, a int, b int) int {
    n := len(graph)
    dist := make([]int, n)
    for i := range dist {
        dist[i] = 1 << 63
    }
    dist[a] = 0
    for i := 0; i < n; i++ {
        for u := 0; u < n; u++ {
            if dist[u] == 1<<63 {
                continue
            }
            for v := 0; v < n; v++ {
                if graph[u][v] > 0 && dist[v] > dist[u]+graph[u][v] {
                    dist[v] = dist[u] + graph[u][v]
                }
            }
        }
    }
    return dist[b]
}
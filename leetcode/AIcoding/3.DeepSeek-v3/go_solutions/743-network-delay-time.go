func networkDelayTime(times [][]int, n int, k int) int {
    const inf = math.MaxInt32
    graph := make([][]int, n+1)
    for i := range graph {
        graph[i] = make([]int, n+1)
        for j := range graph[i] {
            graph[i][j] = inf
        }
    }
    for _, time := range times {
        u, v, w := time[0], time[1], time[2]
        graph[u][v] = w
    }

    dist := make([]int, n+1)
    for i := range dist {
        dist[i] = inf
    }
    dist[k] = 0

    visited := make([]bool, n+1)

    for i := 0; i < n; i++ {
        u := -1
        for v := 1; v <= n; v++ {
            if !visited[v] && (u == -1 || dist[v] < dist[u]) {
                u = v
            }
        }
        if u == -1 || dist[u] == inf {
            break
        }
        visited[u] = true

        for v := 1; v <= n; v++ {
            if graph[u][v] != inf && dist[v] > dist[u]+graph[u][v] {
                dist[v] = dist[u] + graph[u][v]
            }
        }
    }

    maxTime := 0
    for i := 1; i <= n; i++ {
        if dist[i] == inf {
            return -1
        }
        if dist[i] > maxTime {
            maxTime = dist[i]
        }
    }
    return maxTime
}
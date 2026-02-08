func networkBecomesIdle(edges [][]int, patience []int) int {
    n := len(patience)
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = -1
    }
    dist[0] = 0
    queue := []int{0}

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for _, v := range graph[u] {
            if dist[v] == -1 {
                dist[v] = dist[u] + 1
                queue = append(queue, v)
            }
        }
    }

    maxIdleTime := 0
    for i := 1; i < n; i++ {
        time := dist[i] * 2
        if time <= patience[i] {
            maxIdleTime = max(maxIdleTime, time)
        } else {
            maxIdleTime = max(maxIdleTime, time+(time-patience[i]+patience[i]-1)/patience[i]*patience[i])
        }
    }

    return maxIdleTime + 1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func secondMinimum(n int, edges [][]int, time int, change int) int {
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    dist := make([][2]int, n+1)
    for i := 1; i <= n; i++ {
        dist[i][0] = math.MaxInt32
        dist[i][1] = math.MaxInt32
    }
    dist[1][0] = 0

    q := [][2]int{{1, 0}}
    for len(q) > 0 {
        node, d := q[0][0], q[0][1]
        q = q[1:]

        for _, neighbor := range adj[node] {
            if d+1 < dist[neighbor][0] {
                dist[neighbor][0] = d + 1
                q = append(q, [2]int{neighbor, d + 1})
            } else if d+1 > dist[neighbor][0] && d+1 < dist[neighbor][1] {
                dist[neighbor][1] = d + 1
                q = append(q, [2]int{neighbor, d + 1})
            }
        }
    }

    totalTime := 0
    for i := 0; i < dist[n][1]; i++ {
        totalTime += time
        if i < dist[n][1]-1 && (totalTime/change)%2 == 1 {
            totalTime = (totalTime/change + 1) * change
        }
    }
    return totalTime
}
func networkBecomesIdle(edges [][]int, patience []int) int {
    n := len(patience)
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    dist := make([]int, n)
    for i := range dist {
        dist[i] = -1
    }
    q := []int{0}
    dist[0] = 0

    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        for _, v := range adj[u] {
            if dist[v] == -1 {
                dist[v] = dist[u] + 1
                q = append(q, v)
            }
        }
    }

    maxTime := 0
    for i := 1; i < n; i++ {
        d := dist[i] * 2
        p := patience[i]
        var lastSent int
        if d <= p {
            lastSent = 0
        } else {
            lastSent = (d - 1) / p * p
        }
        total := lastSent + d
        if total > maxTime {
            maxTime = total
        }
    }
    return maxTime + 1
}
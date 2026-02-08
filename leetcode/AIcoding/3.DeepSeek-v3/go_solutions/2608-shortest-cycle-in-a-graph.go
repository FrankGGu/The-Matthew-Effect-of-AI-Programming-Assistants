func findShortestCycle(n int, edges [][]int) int {
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    minCycle := math.MaxInt32

    for i := 0; i < n; i++ {
        dist := make([]int, n)
        for j := range dist {
            dist[j] = -1
        }
        parent := make([]int, n)
        for j := range parent {
            parent[j] = -1
        }
        q := []int{i}
        dist[i] = 0

        for len(q) > 0 {
            u := q[0]
            q = q[1:]

            for _, v := range adj[u] {
                if dist[v] == -1 {
                    dist[v] = dist[u] + 1
                    parent[v] = u
                    q = append(q, v)
                } else if parent[u] != v && parent[v] != u {
                    cycleLength := dist[u] + dist[v] + 1
                    if cycleLength < minCycle {
                        minCycle = cycleLength
                    }
                }
            }
        }
    }

    if minCycle == math.MaxInt32 {
        return -1
    }
    return minCycle
}
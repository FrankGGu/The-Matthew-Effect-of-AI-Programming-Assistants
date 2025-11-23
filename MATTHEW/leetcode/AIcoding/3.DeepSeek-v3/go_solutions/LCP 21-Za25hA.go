func chaseGame(edges [][]int, startA int, startB int) int {
    n := len(edges) + 1
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    // BFS to find distance from A and B
    distA := make([]int, n+1)
    distB := make([]int, n+1)
    bfs := func(start int, dist []int) {
        for i := range dist {
            dist[i] = -1
        }
        q := []int{start}
        dist[start] = 0
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
    }
    bfs(startA, distA)
    bfs(startB, distB)

    // Find the cycle length
    cycleLen := 0
    visited := make([]bool, n+1)
    parent := make([]int, n+1)
    var findCycle func(u, p int) bool
    findCycle = func(u, p int) bool {
        visited[u] = true
        parent[u] = p
        for _, v := range adj[u] {
            if v == p {
                continue
            }
            if visited[v] {
                // Found cycle
                cycleLen = 1
                for cur := u; cur != v; cur = parent[cur] {
                    cycleLen++
                }
                return true
            }
            if findCycle(v, u) {
                return true
            }
        }
        return false
    }
    findCycle(1, -1)

    maxDist := 0
    for u := 1; u <= n; u++ {
        if distA[u] > distB[u]+1 {
            if cycleLen > 3 {
                return -1
            } else {
                maxDist = max(maxDist, distA[u])
            }
        }
    }
    return maxDist
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func countSubgraphsForEachDiameter(n int, edges [][]int) []int {
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    dist := make([][]int, n+1)
    for i := 1; i <= n; i++ {
        dist[i] = make([]int, n+1)
        for j := 1; j <= n; j++ {
            dist[i][j] = -1
        }
        q := []int{i}
        dist[i][i] = 0
        for len(q) > 0 {
            u := q[0]
            q = q[1:]
            for _, v := range adj[u] {
                if dist[i][v] == -1 {
                    dist[i][v] = dist[i][u] + 1
                    q = append(q, v)
                }
            }
        }
    }

    res := make([]int, n-1)
    for mask := 1; mask < (1 << n); mask++ {
        nodes := []int{}
        for i := 0; i < n; i++ {
            if mask & (1 << i) != 0 {
                nodes = append(nodes, i+1)
            }
        }
        if len(nodes) < 2 {
            continue
        }

        maxDist := 0
        connected := true
        for _, u := range nodes {
            hasNeighbor := false
            for _, v := range nodes {
                if u == v {
                    continue
                }
                if dist[u][v] == 1 {
                    hasNeighbor = true
                    break
                }
            }
            if !hasNeighbor {
                connected = false
                break
            }
        }
        if !connected {
            continue
        }

        for i := 0; i < len(nodes); i++ {
            for j := i+1; j < len(nodes); j++ {
                u, v := nodes[i], nodes[j]
                if dist[u][v] > maxDist {
                    maxDist = dist[u][v]
                }
            }
        }
        if maxDist > 0 {
            res[maxDist-1]++
        }
    }
    return res
}
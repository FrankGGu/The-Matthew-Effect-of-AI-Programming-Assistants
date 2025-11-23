func collectTheCoins(coins []int, edges [][]int) int {
    n := len(coins)
    adj := make([][]int, n)
    degree := make([]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
        degree[u]++
        degree[v]++
    }

    q := make([]int, 0)
    for i := 0; i < n; i++ {
        if degree[i] == 1 && coins[i] == 0 {
            q = append(q, i)
        }
    }

    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        for _, v := range adj[u] {
            degree[v]--
            if degree[v] == 1 && coins[v] == 0 {
                q = append(q, v)
            }
        }
    }

    q = make([]int, 0)
    dist := make([]int, n)
    for i := 0; i < n; i++ {
        if degree[i] == 1 && coins[i] == 1 {
            q = append(q, i)
            dist[i] = 1
        }
    }

    for len(q) > 0 {
        u := q[0]
        q = q[1:]
        for _, v := range adj[u] {
            if degree[v] > 0 {
                degree[v]--
                if degree[v] == 1 {
                    dist[v] = dist[u] + 1
                    q = append(q, v)
                }
            }
        }
    }

    maxDist := 0
    for _, d := range dist {
        if d > maxDist {
            maxDist = d
        }
    }

    if maxDist == 0 {
        return 0
    }
    return 2 * (maxDist - 1)
}
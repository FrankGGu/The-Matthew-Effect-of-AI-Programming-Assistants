func minimumTotalPrice(n int, edges [][]int, price []int, trips [][]int) int {
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    count := make([]int, n)
    var dfs func(node, target, parent int) bool
    dfs = func(node, target, parent int) bool {
        if node == target {
            count[node]++
            return true
        }
        for _, neighbor := range adj[node] {
            if neighbor != parent {
                if dfs(neighbor, target, node) {
                    count[node]++
                    return true
                }
            }
        }
        return false
    }

    for _, trip := range trips {
        start, end := trip[0], trip[1]
        dfs(start, end, -1)
    }

    memo := make([][]int, n)
    for i := range memo {
        memo[i] = make([]int, 2)
        memo[i][0] = -1
        memo[i][1] = -1
    }

    var dp func(node, hasHalved, parent int) int
    dp = func(node, hasHalved, parent int) int {
        if memo[node][hasHalved] != -1 {
            return memo[node][hasHalved]
        }

        notHalved := price[node] * count[node]
        halved := price[node] / 2 * count[node]

        for _, neighbor := range adj[node] {
            if neighbor != parent {
                notHalved += min(dp(neighbor, 0, node), dp(neighbor, 1, node))
                halved += dp(neighbor, 0, node)
            }
        }

        if hasHalved == 1 {
            memo[node][hasHalved] = notHalved
            return notHalved
        } else {
            memo[node][hasHalved] = min(notHalved, halved)
            return min(notHalved, halved)
        }
    }

    return min(dp(0, 0, -1), dp(0, 1, -1))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
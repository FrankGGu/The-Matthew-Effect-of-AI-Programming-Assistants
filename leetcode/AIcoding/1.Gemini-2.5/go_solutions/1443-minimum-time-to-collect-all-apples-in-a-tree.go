func minTime(n int, edges [][]int, hasApple []bool) int {
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    totalTime := 0
    dfs(0, -1, adj, hasApple, &totalTime)
    return totalTime
}

func dfs(u, parent int, adj [][]int, hasApple []bool, totalTime *int) bool {
    hasAppleInSubtree := hasApple[u]

    for _, v := range adj[u] {
        if v == parent {
            continue
        }
        childHasApple := dfs(v, u, adj, hasApple, totalTime)
        if childHasApple {
            hasAppleInSubtree = true
            *totalTime += 2
        }
    }
    return hasAppleInSubtree
}
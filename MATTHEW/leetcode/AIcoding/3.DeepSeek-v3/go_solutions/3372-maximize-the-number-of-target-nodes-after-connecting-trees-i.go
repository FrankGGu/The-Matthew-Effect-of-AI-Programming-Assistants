func maximumTargetNodesAfterConnectingTrees(n int, edges [][]int, target []int) int {
    adj := make([][]int, n+1)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    targetSet := make(map[int]bool)
    for _, t := range target {
        targetSet[t] = true
    }

    var dfs func(int, int) int
    dfs = func(u, parent int) int {
        res := 0
        for _, v := range adj[u] {
            if v != parent {
                res += dfs(v, u)
            }
        }
        if targetSet[u] || res > 0 {
            return res + 1
        }
        return 0
    }

    maxNodes := 0
    for _, t := range target {
        cnt := dfs(t, -1)
        if cnt > maxNodes {
            maxNodes = cnt
        }
    }
    return maxNodes
}
func maxWeight(edges [][]int, k int) int {
    n := 0
    for _, edge := range edges {
        if edge[0] > n {
            n = edge[0]
        }
        if edge[1] > n {
            n = edge[1]
        }
    }
    n++

    graph := make([][][2]int, n)
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        graph[u] = append(graph[u], [2]int{v, w})
        graph[v] = append(graph[v], [2]int{u, w})
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(u, step int) int
    dfs = func(u, step int) int {
        if step == 0 {
            return 0
        }
        if dp[u][step] != -1 {
            return dp[u][step]
        }

        max := -1
        for _, neighbor := range graph[u] {
            v, w := neighbor[0], neighbor[1]
            res := dfs(v, step-1)
            if res != -1 && res + w > max {
                max = res + w
            }
        }
        dp[u][step] = max
        return max
    }

    result := -1
    for i := 0; i < n; i++ {
        res := dfs(i, k)
        if res > result {
            result = res
        }
    }
    return result
}
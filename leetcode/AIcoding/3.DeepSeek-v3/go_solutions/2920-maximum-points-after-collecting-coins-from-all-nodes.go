func maximumPoints(edges [][]int, coins []int, k int) int {
    n := len(coins)
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    memo := make([][]int, n)
    for i := range memo {
        memo[i] = make([]int, 14)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(int, int, int) int
    dfs = func(u, parent, t int) int {
        if t >= 14 {
            return 0
        }
        if memo[u][t] != -1 {
            return memo[u][t]
        }

        option1 := (coins[u] >> t) - k
        option2 := coins[u] >> (t + 1)

        for _, v := range graph[u] {
            if v != parent {
                option1 += dfs(v, u, t)
                option2 += dfs(v, u, t+1)
            }
        }

        memo[u][t] = max(option1, option2)
        return memo[u][t]
    }

    return dfs(0, -1, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
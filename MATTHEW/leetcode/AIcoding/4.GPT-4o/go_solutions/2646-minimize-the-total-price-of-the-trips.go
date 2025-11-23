func minimizeTotalPrice(n int, edges [][]int, price []int) int64 {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    dp := make([]int64, n)
    visited := make([]bool, n)

    var dfs func(node, parent int) int64
    dfs = func(node, parent int) int64 {
        visited[node] = true
        total := int64(price[node])
        dp[node] = total / 2

        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            dp[node] += dfs(neighbor, node)
        }
        return dp[node]
    }

    dfs(0, -1)

    var ans int64
    for i := 0; i < n; i++ {
        if !visited[i] {
            ans += dp[i]
        }
    }

    return ans
}
func numOfMessages(n int, relations [][]int, time []int) int {
    graph := make([][]int, n)
    for _, relation := range relations {
        graph[relation[0]] = append(graph[relation[0]], relation[1])
    }

    dp := make([]int, n)
    var dfs func(node int) int
    dfs = func(node int) int {
        if dp[node] != 0 {
            return dp[node]
        }
        maxTime := 0
        for _, neighbor := range graph[node] {
            maxTime = max(maxTime, dfs(neighbor))
        }
        dp[node] = maxTime + time[node]
        return dp[node]
    }

    maxMessageTime := 0
    for i := 0; i < n; i++ {
        maxMessageTime = max(maxMessageTime, dfs(i))
    }

    return maxMessageTime
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
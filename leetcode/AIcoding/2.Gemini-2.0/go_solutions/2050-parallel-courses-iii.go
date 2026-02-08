func minimumTime(n int, relations [][]int, time []int) int {
    indegree := make([]int, n)
    graph := make([][]int, n)
    for _, relation := range relations {
        prev := relation[0] - 1
        next := relation[1] - 1
        graph[prev] = append(graph[prev], next)
        indegree[next]++
    }

    q := []int{}
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = time[i]
        if indegree[i] == 0 {
            q = append(q, i)
        }
    }

    for len(q) > 0 {
        node := q[0]
        q = q[1:]

        for _, neighbor := range graph[node] {
            indegree[neighbor]--
            dp[neighbor] = max(dp[neighbor], dp[node]+time[neighbor])
            if indegree[neighbor] == 0 {
                q = append(q, neighbor)
            }
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        ans = max(ans, dp[i])
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
package main

func maxProfitAssignment(n int, edges [][]int, price []int) int {
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
    }

    inDegree := make([]int, n)
    for _, e := range edges {
        inDegree[e[1]]++
    }

    queue := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = price[i]
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]

        for _, v := range graph[u] {
            dp[v] = max(dp[v], dp[u]+price[v])
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    maxProfit := 0
    for i := 0; i < n; i++ {
        maxProfit = max(maxProfit, dp[i])
    }
    return maxProfit
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
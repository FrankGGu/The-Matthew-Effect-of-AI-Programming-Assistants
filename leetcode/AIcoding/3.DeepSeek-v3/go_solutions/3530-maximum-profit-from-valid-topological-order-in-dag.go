func maxProfitInDAG(n int, edges [][]int, profit []int) int {
    inDegree := make([]int, n)
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    queue := []int{}
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    dp := make([]int, n)
    copy(dp, profit)

    maxProfit := 0
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        if dp[u] > maxProfit {
            maxProfit = dp[u]
        }
        for _, v := range graph[u] {
            if dp[v] < dp[u]+profit[v] {
                dp[v] = dp[u] + profit[v]
            }
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return maxProfit
}
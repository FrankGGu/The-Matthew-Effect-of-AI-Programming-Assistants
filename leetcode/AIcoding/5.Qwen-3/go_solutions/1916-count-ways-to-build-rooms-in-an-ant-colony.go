package main

func countWays(n int, relations [][]int) int {
    mod := 1000000007
    inDegree := make([]int, n)
    graph := make([][]int, n)
    for _, rel := range relations {
        u, v := rel[0], rel[1]
        graph[u] = append(graph[u], v)
        inDegree[v]++
    }

    queue := make([]int, 0)
    for i := 0; i < n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }

    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        for _, v := range graph[u] {
            dp[v] = (dp[v] + dp[u]) % mod
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return dp[n-1]
}
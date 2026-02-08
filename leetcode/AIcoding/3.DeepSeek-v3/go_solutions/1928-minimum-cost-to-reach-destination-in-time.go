func minCost(maxTime int, edges [][]int, passingFees []int) int {
    n := len(passingFees)
    const inf = 1 << 30
    dp := make([][]int, maxTime+1)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = inf
        }
    }
    dp[0][0] = passingFees[0]

    for t := 0; t <= maxTime; t++ {
        for _, edge := range edges {
            u, v, time := edge[0], edge[1], edge[2]
            if t >= time {
                if newCost := dp[t-time][u] + passingFees[v]; newCost < dp[t][v] {
                    dp[t][v] = newCost
                }
                if newCost := dp[t-time][v] + passingFees[u]; newCost < dp[t][u] {
                    dp[t][u] = newCost
                }
            }
        }
    }

    res := inf
    for t := 0; t <= maxTime; t++ {
        if dp[t][n-1] < res {
            res = dp[t][n-1]
        }
    }
    if res == inf {
        return -1
    }
    return res
}
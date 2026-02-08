func maximumSum(arr []int) int {
    n := len(arr)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = arr[0]
    maxSum := dp[0]

    for i := 1; i < n; i++ {
        dp[i] = max(arr[i], dp[i-1]+arr[i])
        maxSum = max(maxSum, dp[i])
    }

    dp1 := make([]int, n)
    dp1[0] = 0
    maxSumWithOneRemoval := maxSum

    for i := 1; i < n; i++ {
        dp1[i] = max(dp1[i-1], dp[i-1])
        maxSumWithOneRemoval = max(maxSumWithOneRemoval, dp[i]+dp1[i])
    }

    return maxSumWithOneRemoval
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
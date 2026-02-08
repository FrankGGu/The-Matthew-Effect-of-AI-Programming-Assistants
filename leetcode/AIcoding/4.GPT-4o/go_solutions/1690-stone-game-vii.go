func stoneGameVII(stones []int) int {
    n := len(stones)
    prefixSum := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + stones[i]
    }
    total := prefixSum[n]
    dp1, dp2 := 0, 0
    for i := 0; i < n; i++ {
        dp1 = max(dp1, total-prefixSum[i+1]-dp2)
        dp2 = max(dp2, total-prefixSum[i]-dp1)
    }
    return dp1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
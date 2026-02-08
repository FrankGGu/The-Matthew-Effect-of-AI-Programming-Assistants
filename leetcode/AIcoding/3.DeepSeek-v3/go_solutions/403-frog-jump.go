func canCross(stones []int) bool {
    n := len(stones)
    dp := make(map[int]map[int]bool)
    for _, stone := range stones {
        dp[stone] = make(map[int]bool)
    }
    dp[0][0] = true

    for i := 0; i < n; i++ {
        currentStone := stones[i]
        for k := range dp[currentStone] {
            for step := k - 1; step <= k + 1; step++ {
                if step > 0 {
                    nextStone := currentStone + step
                    if _, exists := dp[nextStone]; exists {
                        dp[nextStone][step] = true
                    }
                }
            }
        }
    }

    return len(dp[stones[n-1]]) > 0
}
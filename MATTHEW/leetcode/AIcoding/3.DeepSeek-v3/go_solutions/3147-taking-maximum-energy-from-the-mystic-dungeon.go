func maximumEnergy(energy []int, k int) int {
    n := len(energy)
    maxEnergy := -1001
    dp := make([]int, n)

    for i := n - 1; i >= 0; i-- {
        dp[i] = energy[i]
        if i + k < n {
            dp[i] += dp[i+k]
        }
        if dp[i] > maxEnergy {
            maxEnergy = dp[i]
        }
    }

    return maxEnergy
}
func lastStoneWeightII(stones []int) int {
    totalWeight := 0
    for _, stone := range stones {
        totalWeight += stone
    }
    n := len(stones)
    target := totalWeight / 2

    dp := make([]bool, target+1)
    dp[0] = true

    for _, stone := range stones {
        for j := target; j >= stone; j-- {
            dp[j] = dp[j] || dp[j-stone]
        }
    }

    for i := target; i >= 0; i-- {
        if dp[i] {
            return totalWeight - 2*i
        }
    }
    return totalWeight
}
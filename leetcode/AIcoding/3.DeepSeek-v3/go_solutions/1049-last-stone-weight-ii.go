func lastStoneWeightII(stones []int) int {
    sum := 0
    for _, stone := range stones {
        sum += stone
    }
    target := sum / 2
    dp := make([]bool, target+1)
    dp[0] = true
    max := 0
    for _, stone := range stones {
        for j := target; j >= stone; j-- {
            if dp[j-stone] {
                dp[j] = true
                if j > max {
                    max = j
                }
            }
        }
    }
    return sum - 2*max
}
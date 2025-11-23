func maxTotalReward(rewardValues []int) int {
    maxVal := 0
    for _, v := range rewardValues {
        if v > maxVal {
            maxVal = v
        }
    }
    dp := make([]bool, maxVal*2)
    dp[0] = true
    sort.Ints(rewardValues)
    for _, num := range rewardValues {
        for i := num - 1; i >= 0; i-- {
            if dp[i] {
                dp[i+num] = true
            }
        }
    }
    for i := len(dp) - 1; i >= 0; i-- {
        if dp[i] {
            return i
        }
    }
    return 0
}
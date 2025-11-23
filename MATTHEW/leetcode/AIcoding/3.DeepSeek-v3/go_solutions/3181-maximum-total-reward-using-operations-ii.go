func maxTotalReward(rewardValues []int) int {
    maxVal := 0
    for _, v := range rewardValues {
        if v > maxVal {
            maxVal = v
        }
    }
    maxSum := maxVal * 2
    dp := make([]bool, maxSum)
    dp[0] = true
    sort.Ints(rewardValues)

    for _, num := range rewardValues {
        for j := num; j < maxSum; j++ {
            if dp[j - num] && j - num < num {
                dp[j] = true
            }
        }
    }

    for j := maxSum - 1; j >= 0; j-- {
        if dp[j] {
            return j
        }
    }
    return 0
}
func minChocoBoxes(chocoBoxes [][]int, target int) int {
    dp := make([]int, target+1)
    for i := range dp {
        dp[i] = math.MaxInt32
    }
    dp[0] = 0

    for _, box := range chocoBoxes {
        choco := box[0]
        count := box[1]
        for j := target; j >= choco; j-- {
            if dp[j-choco] != math.MaxInt32 {
                dp[j] = min(dp[j], dp[j-choco]+count)
            }
        }
    }

    if dp[target] == math.MaxInt32 {
        return -1
    }
    return dp[target]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
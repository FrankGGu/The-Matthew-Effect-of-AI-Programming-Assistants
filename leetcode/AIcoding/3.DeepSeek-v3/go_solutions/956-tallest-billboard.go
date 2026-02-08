func tallestBillboard(rods []int) int {
    dp := make(map[int]int)
    dp[0] = 0
    for _, r := range rods {
        temp := make(map[int]int)
        for k, v := range dp {
            temp[k] = v
        }
        for diff, maxHeight := range temp {
            newDiff := diff + r
            newMax := maxHeight + r
            if val, ok := dp[newDiff]; !ok || newMax > val {
                dp[newDiff] = newMax
            }
            newDiff = abs(diff - r)
            newMax = max(maxHeight, maxHeight - diff + r)
            if val, ok := dp[newDiff]; !ok || newMax > val {
                dp[newDiff] = newMax
            }
        }
    }
    return dp[0]
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
func largestNumber(cost []int, target int) string {
    dp := make([]string, target+1)
    for i := 1; i <= target; i++ {
        dp[i] = "0"
        for d := 9; d >= 1; d-- {
            if i >= cost[d-1] {
                prev := dp[i-cost[d-1]]
                if prev == "0" && i != cost[d-1] {
                    continue
                }
                candidate := prev + strconv.Itoa(d)
                if len(candidate) > len(dp[i]) || (len(candidate) == len(dp[i]) && candidate > dp[i]) {
                    dp[i] = candidate
                }
            }
        }
    }
    return dp[target]
}
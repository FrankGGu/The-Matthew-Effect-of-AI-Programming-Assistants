func minCost(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = math.MaxInt32
    }

    for i := 0; i < n; i++ {
        freq := make(map[int]int)
        trimmed := 0
        for j := i; j >= 0; j-- {
            num := nums[j]
            freq[num]++
            if freq[num] == 2 {
                trimmed += 2
            } else if freq[num] > 2 {
                trimmed += 1
            }
            cost := k + trimmed
            if dp[j] + cost < dp[i+1] {
                dp[i+1] = dp[j] + cost
            }
        }
    }
    return dp[n]
}
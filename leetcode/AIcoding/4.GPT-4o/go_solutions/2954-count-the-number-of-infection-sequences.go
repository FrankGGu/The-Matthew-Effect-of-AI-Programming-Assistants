func countSequences(infected []int) int {
    n := len(infected)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = 1

    for i := 1; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if infected[i] >= infected[j] {
                dp[i] += dp[j]
            }
        }
    }

    total := 0
    for _, count := range dp {
        total += count
    }

    return total
}
func racecar(target int) int {
    dp := make([]int, target+1)
    for i := 1; i <= target; i++ {
        dp[i] = math.MaxInt32
        m, j := 1, 1
        for j < i {
            for p, q := 0, 0; p < j; p, q = p+1, q+1 {
                if dp[i] > m+1+q+1+dp[i-(j-p)] {
                    dp[i] = m + 1 + q + 1 + dp[i-(j-p)]
                }
            }
            m++
            j = (1 << uint(m)) - 1
        }
        if j == i {
            dp[i] = m
        } else {
            if dp[i] > m+1+dp[j-i] {
                dp[i] = m + 1 + dp[j-i]
            }
        }
    }
    return dp[target]
}
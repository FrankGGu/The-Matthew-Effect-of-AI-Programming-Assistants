func longestArithSeqLength(A []int) int {
    n := len(A)
    if n <= 2 {
        return n
    }

    dp := make([]map[int]int, n)
    for i := range dp {
        dp[i] = make(map[int]int)
    }

    maxLength := 2

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            diff := A[i] - A[j]
            dp[i][diff] = dp[j][diff] + 1
            if dp[i][diff] > maxLength {
                maxLength = dp[i][diff]
            }
        }
    }

    return maxLength + 1
}
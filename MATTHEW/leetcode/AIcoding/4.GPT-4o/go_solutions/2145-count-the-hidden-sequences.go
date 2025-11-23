func countHiddenSequences(A []int, B []int) int {
    n, m := len(A), len(B)
    dp := make([]int, m+1)
    dp[0] = 1

    for i := 0; i < n; i++ {
        for j := m; j > 0; j-- {
            if A[i] == B[j-1] {
                dp[j] += dp[j-1]
            }
        }
    }

    return dp[m]
}
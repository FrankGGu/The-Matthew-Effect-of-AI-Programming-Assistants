func maxHeight(A []int) int {
    sort.Ints(A)
    n := len(A)
    dp := make([]int, n)
    dp[0] = A[0]

    for i := 1; i < n; i++ {
        dp[i] = A[i]
        for j := 0; j < i; j++ {
            if A[j] < A[i] {
                dp[i] = max(dp[i], dp[j]+A[i])
            }
        }
    }

    maxHeight := 0
    for _, h := range dp {
        maxHeight = max(maxHeight, h)
    }
    return maxHeight
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
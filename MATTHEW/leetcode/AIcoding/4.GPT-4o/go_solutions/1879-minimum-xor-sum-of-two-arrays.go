func minimumXORSum(A []int, B []int) int {
    n := len(A)
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = 1<<31 - 1
    }
    dp[0] = 0

    for mask := 0; mask < 1<<n; mask++ {
        count := 0
        for j := 0; j < n; j++ {
            if (mask>>j)&1 == 1 {
                count++
            }
        }
        if count > len(B) {
            continue
        }
        for j := 0; j < n; j++ {
            if (mask>>j)&1 == 0 {
                nextMask := mask | (1 << j)
                dp[nextMask] = min(dp[nextMask], dp[mask]+(A[j]^B[count]))
            }
        }
    }

    return dp[(1<<n)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
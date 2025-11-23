func minDeletionSize(A []string) int {
    n := len(A)
    m := len(A[0])
    dp := make([]int, m)

    for j := 0; j < m; j++ {
        dp[j] = 1
        for k := 0; k < j; k++ {
            if isSorted(A, k, j) {
                dp[j] = max(dp[j], dp[k]+1)
            }
        }
    }

    return m - max(dp...)
}

func isSorted(A []string, col1, col2 int) bool {
    for i := 1; i < len(A); i++ {
        if A[i][col1] > A[i-1][col1] && A[i][col2] < A[i-1][col2] {
            return false
        }
    }
    return true
}

func max(nums ...int) int {
    maxVal := nums[0]
    for _, v := range nums {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}
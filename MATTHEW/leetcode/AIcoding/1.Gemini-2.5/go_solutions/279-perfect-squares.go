import "math"

func numSquares(n int) int {
    dp := make([]int, n+1)
    dp[0] = 0

    for i := 1; i <= n; i++ {
        dp[i] = math.MaxInt32 // Initialize with a very large number
        for j :=
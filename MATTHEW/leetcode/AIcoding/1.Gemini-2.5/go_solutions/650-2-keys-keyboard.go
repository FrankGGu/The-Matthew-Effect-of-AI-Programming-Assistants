package solution

func minSteps(n int) int {
    if n == 1 {
        return 0
    }

    dp := make([]int, n+1)
    dp[1] = 0 // Base case: 1 'A' requires 0 operations

    for i := 2; i <= n; i++ {
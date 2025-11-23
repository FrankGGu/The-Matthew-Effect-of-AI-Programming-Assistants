func minimumDeleteSum(s1 string, s2 string) int {
    m := len(s1)
    n := len(s2)

    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    // Initialize
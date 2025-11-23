func numberOfWays(startPos int, endPos int, k int) int {
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, 3001)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var solve func(currPos int, steps int) int
    solve = func(currPos int, steps int) int {
        if steps == 0 {
            if currPos == endPos {
                return 1
            } else {
                return 0
            }
        }

        pos := currPos + 1500
        if pos < 0 || pos >= 3001 {
            return 0
        }

        if dp[steps][pos] != -1 {
            return dp[steps][pos]
        }

        mod := 1000000007

        dp[steps][pos] = (solve(currPos+1, steps-1) + solve(currPos-1, steps-1)) % mod
        return dp[steps][pos]
    }

    return solve(startPos, k)
}
func canWinGame(positions []int) bool {
    dp := make(map[int]bool)
    var dfs func(pos int) bool
    dfs = func(pos int) bool {
        if res, ok := dp[pos]; ok {
            return res
        }
        for _, p := range positions {
            if pos+p > 0 && !dfs(pos+p) {
                dp[pos] = true
                return true
            }
        }
        dp[pos] = false
        return false
    }
    return dfs(0)
}
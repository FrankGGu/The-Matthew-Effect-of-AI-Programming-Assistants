func numberOfWays(startPos int, endPos int, k int) int {
    mod := int(1e9 + 7)
    dp := make(map[[2]int]int)

    var dfs func(pos, steps int) int
    dfs = func(pos, steps int) int {
        if steps == 0 {
            if pos == endPos {
                return 1
            }
            return 0
        }
        key := [2]int{pos, steps}
        if val, ok := dp[key]; ok {
            return val
        }
        res := (dfs(pos+1, steps-1) + dfs(pos-1, steps-1)) % mod
        dp[key] = res
        return res
    }

    return dfs(startPos, k)
}
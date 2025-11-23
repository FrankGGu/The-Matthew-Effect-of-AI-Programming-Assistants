func waysToReachStair(k int) int {
    memo := make(map[[2]int]int)
    var dfs func(int, int, bool) int
    dfs = func(pos, jump int, prevDown bool) int {
        if pos > k+1 {
            return 0
        }
        key := [2]int{pos, jump}
        if val, ok := memo[key]; ok {
            return val
        }
        res := 0
        if pos == k {
            res++
        }
        if pos >= 1 {
            if !prevDown {
                res += dfs(pos-1, jump, true)
            }
        }
        res += dfs(pos+(1<<jump), jump+1, false)
        memo[key] = res
        return res
    }
    return dfs(1, 0, false)
}
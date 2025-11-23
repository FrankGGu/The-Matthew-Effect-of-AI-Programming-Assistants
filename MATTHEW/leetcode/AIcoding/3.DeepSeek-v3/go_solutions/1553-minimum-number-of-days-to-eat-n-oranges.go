func minDays(n int) int {
    memo := make(map[int]int)
    return dfs(n, memo)
}

func dfs(n int, memo map[int]int) int {
    if n <= 1 {
        return n
    }
    if val, ok := memo[n]; ok {
        return val
    }
    res := 1 + min(n%2 + dfs(n/2, memo), n%3 + dfs(n/3, memo))
    memo[n] = res
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
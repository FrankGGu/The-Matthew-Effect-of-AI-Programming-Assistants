package main

func minDays(n int) int {
    memo := make(map[int]int)
    var dfs func(int) int
    dfs = func(x int) int {
        if x <= 1 {
            return x
        }
        if v, ok := memo[x]; ok {
            return v
        }
        res := 1 + min(dfs(x/2)+x%2, dfs(x/3)+x%3)
        memo[x] = res
        return res
    }
    return dfs(n)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
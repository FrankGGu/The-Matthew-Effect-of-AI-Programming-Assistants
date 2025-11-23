package main

func minDays(n int) int {
    memo := make(map[int]int)
    var dfs func(int) int
    dfs = func(oranges int) int {
        if oranges <= 1 {
            return oranges
        }
        if val, ok := memo[oranges]; ok {
            return val
        }
        days := 1 + min(dfs(oranges/2)+oranges%2, dfs(oranges/3)+oranges%3)
        memo[oranges] = days
        return days
    }
    return dfs(n)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
func tilingRectangle(n int, m int) int {
    memo := make(map[[2]int]int)
    return dfs(n, m, memo)
}

func dfs(n, m int, memo map[[2]int]int) int {
    if n == m {
        return 1
    }
    if n == 0 || m == 0 {
        return 0
    }
    key := [2]int{n, m}
    if val, ok := memo[key]; ok {
        return val
    }
    res := n * m
    for i := 1; i <= min(n, m); i++ {
        res = min(res, 1 + dfs(n-i, m, memo) + dfs(i, m-i, memo))
        res = min(res, 1 + dfs(n, m-i, memo) + dfs(n-i, i, memo))
    }
    memo[key] = res
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
package main

func leastOpsExpressNumber(n int) int {
    memo := map[int]int{}
    var dfs func(int, int) int
    dfs = func(n, i int) int {
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        if v, ok := memo[n]; ok {
            return v
        }
        pow := 1 << i
        nextPow := pow << 1
        res := dfs(n-pow, i+1) + 1
        if nextPow-n < n-pow {
            res = min(res, dfs(nextPow-n, i+1)+1)
        }
        memo[n] = res
        return res
    }
    return dfs(n, 0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
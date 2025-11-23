package main

func maxJumps(arr []int, a int, b int) int {
    n := len(arr)
    memo := make([]int, n)
    for i := range memo {
        memo[i] = -1
    }

    var dfs func(int) int
    dfs = func(i int) int {
        if i < 0 || i >= n {
            return 0
        }
        if memo[i] != -1 {
            return memo[i]
        }

        res := 0
        if i+a < n {
            res = max(res, dfs(i+a)+1)
        }
        if i-b >= 0 {
            res = max(res, dfs(i-b)+1)
        }

        memo[i] = res
        return res
    }

    maxVal := 0
    for i := 0; i < n; i++ {
        maxVal = max(maxVal, dfs(i))
    }

    return maxVal
}

func max(x, y int) int {
    if x > y {
        return x
    }
    return y
}
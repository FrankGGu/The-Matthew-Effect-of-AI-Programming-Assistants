func maxProductPath(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxDp := make([][]int, m)
    minDp := make([][]int, m)
    for i := range maxDp {
        maxDp[i] = make([]int, n)
        minDp[i] = make([]int, n)
    }

    maxDp[0][0] = grid[0][0]
    minDp[0][0] = grid[0][0]

    for i := 1; i < m; i++ {
        val := maxDp[i-1][0] * grid[i][0]
        maxDp[i][0] = val
        minDp[i][0] = val
    }

    for j := 1; j < n; j++ {
        val := maxDp[0][j-1] * grid[0][j]
        maxDp[0][j] = val
        minDp[0][j] = val
    }

    for i := 1; i < m; i++ {
        for j := 1; j < n; j++ {
            val := grid[i][j]
            candidates := []int{
                maxDp[i-1][j] * val,
                minDp[i-1][j] * val,
                maxDp[i][j-1] * val,
                minDp[i][j-1] * val,
            }
            maxDp[i][j] = max(candidates...)
            minDp[i][j] = min(candidates...)
        }
    }

    if maxDp[m-1][n-1] < 0 {
        return -1
    }
    return maxDp[m-1][n-1] % (1e9 + 7)
}

func max(nums ...int) int {
    res := nums[0]
    for _, num := range nums {
        if num > res {
            res = num
        }
    }
    return res
}

func min(nums ...int) int {
    res := nums[0]
    for _, num := range nums {
        if num < res {
            res = num
        }
    }
    return res
}
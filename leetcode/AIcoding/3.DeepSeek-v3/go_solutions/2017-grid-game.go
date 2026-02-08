func gridGame(grid [][]int) int64 {
    n := len(grid[0])
    prefix1 := make([]int64, n+1)
    prefix2 := make([]int64, n+1)

    for i := 0; i < n; i++ {
        prefix1[i+1] = prefix1[i] + int64(grid[0][i])
        prefix2[i+1] = prefix2[i] + int64(grid[1][i])
    }

    var res int64 = 1 << 60
    for i := 0; i < n; i++ {
        option1 := prefix1[n] - prefix1[i+1]
        option2 := prefix2[i]
        maxOption := max(option1, option2)
        if maxOption < res {
            res = maxOption
        }
    }
    return res
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}
func largestLocal(grid [][]int) [][]int {
    n := len(grid)
    res := make([][]int, n-2)
    for i := range res {
        res[i] = make([]int, n-2)
    }

    for i := 0; i < n-2; i++ {
        for j := 0; j < n-2; j++ {
            maxVal := 0
            for x := i; x < i+3; x++ {
                for y := j; y < j+3; y++ {
                    if grid[x][y] > maxVal {
                        maxVal = grid[x][y]
                    }
                }
            }
            res[i][j] = maxVal
        }
    }
    return res
}
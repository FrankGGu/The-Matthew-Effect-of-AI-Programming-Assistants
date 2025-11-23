func largestLocal(grid [][]int) [][]int {
    n := len(grid)
    resSize := n - 2
    res := make([][]int, resSize)
    for i := 0; i < resSize; i++ {
        res[i] = make([]int, resSize)
    }

    for i := 0; i < resSize; i++ {
        for j := 0; j < resSize; j++ {
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
func maxDifferenceScore(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    maxDiff := 0

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            for ii := 0; ii < rows; ii++ {
                for jj := 0; jj < cols; jj++ {
                    if i != ii || j != jj {
                        diff := abs(grid[i][j] - grid[ii][jj])
                        if diff > maxDiff {
                            maxDiff = diff
                        }
                    }
                }
            }
        }
    }
    return maxDiff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}
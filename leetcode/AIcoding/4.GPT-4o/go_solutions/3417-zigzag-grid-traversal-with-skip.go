func zigzagTraversalWithSkip(grid [][]int, k int) []int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return []int{}
    }
    rows, cols := len(grid), len(grid[0])
    result := []int{}
    for i := 0; i < rows; i++ {
        if i%2 == 0 {
            for j := 0; j < cols; j++ {
                if len(result) < k {
                    result = append(result, grid[i][j])
                }
            }
        } else {
            for j := cols - 1; j >= 0; j-- {
                if len(result) < k {
                    result = append(result, grid[i][j])
                }
            }
        }
    }
    return result
}
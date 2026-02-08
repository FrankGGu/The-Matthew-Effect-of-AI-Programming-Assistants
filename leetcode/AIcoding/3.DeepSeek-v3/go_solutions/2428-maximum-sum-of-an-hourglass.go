func maxSum(grid [][]int) int {
    maxSum := 0
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    for i := 0; i < rows-2; i++ {
        for j := 0; j < cols-2; j++ {
            currentSum := grid[i][j] + grid[i][j+1] + grid[i][j+2] +
                          grid[i+1][j+1] +
                          grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2]
            if i == 0 && j == 0 {
                maxSum = currentSum
            } else if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }
    return maxSum
}
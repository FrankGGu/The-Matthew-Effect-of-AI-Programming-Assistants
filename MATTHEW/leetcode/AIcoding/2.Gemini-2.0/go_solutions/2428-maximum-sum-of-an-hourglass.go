func maxSum(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])
    maxSum := 0
    for i := 0; i < m-2; i++ {
        for j := 0; j < n-2; j++ {
            sum := grid[i][j] + grid[i][j+1] + grid[i][j+2] +
                grid[i+1][j+1] +
                grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2]
            if i == 0 && j == 0 {
                maxSum = sum
            } else if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}
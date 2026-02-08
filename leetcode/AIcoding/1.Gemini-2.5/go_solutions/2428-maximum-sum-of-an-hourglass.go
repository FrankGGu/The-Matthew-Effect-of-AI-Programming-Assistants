func maximumSumHourglass(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])

    maxHourglassSum := 0

    for i := 0; i <= m-3; i++ {
        for j := 0; j <= n-3; j++ {
            currentSum := grid[i][j] + grid[i][j+1] + grid[i][j+2] +
                          grid[i+1][j+1] +
                          grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2]

            if currentSum > maxHourglassSum {
                maxHourglassSum = currentSum
            }
        }
    }

    return maxHourglassSum
}
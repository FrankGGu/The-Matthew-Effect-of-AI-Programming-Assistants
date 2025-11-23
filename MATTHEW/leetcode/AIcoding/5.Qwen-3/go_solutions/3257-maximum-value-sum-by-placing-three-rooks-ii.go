package main

func maximumValueSum(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    maxSum := 0
    minDiff := 1e9
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] > 0 {
                maxSum += grid[i][j]
            } else {
                diff := -grid[i][j]
                if diff < minDiff {
                    minDiff = diff
                }
            }
        }
    }
    if minDiff != 1e9 && (maxSum - minDiff) % 2 == 1 {
        maxSum -= minDiff
    }
    return maxSum
}
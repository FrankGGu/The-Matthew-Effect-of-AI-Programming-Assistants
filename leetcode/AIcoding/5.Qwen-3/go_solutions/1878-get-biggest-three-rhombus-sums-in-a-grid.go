package main

func maxSumOfThreeSubarrays(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxSum := 0
    maxSums := make([]int, 3)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for k := 1; i-k >= 0 && j+k < n && i+k < m && j-k >= 0; k++ {
                sum := 0
                for l := 0; l <= k; l++ {
                    sum += grid[i-l][j+l]
                    sum += grid[i-l][j-l]
                    sum += grid[i+l][j+l]
                    sum += grid[i+l][j-l]
                }
                sum -= grid[i][j]
                if sum > maxSums[0] {
                    maxSums[2] = maxSums[1]
                    maxSums[1] = maxSums[0]
                    maxSums[0] = sum
                } else if sum > maxSums[1] {
                    maxSums[2] = maxSums[1]
                    maxSums[1] = sum
                } else if sum > maxSums[2] {
                    maxSums[2] = sum
                }
            }
        }
    }
    return maxSums[0] + maxSums[1] + maxSums[2]
}
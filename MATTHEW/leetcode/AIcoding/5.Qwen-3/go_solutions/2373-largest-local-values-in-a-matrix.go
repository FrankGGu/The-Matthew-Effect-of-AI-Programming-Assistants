package main

func largestLocal(grid [][]int) [][]int {
    n := len(grid)
    result := make([][]int, n-1)
    for i := range result {
        result[i] = make([]int, n-1)
    }
    for i := 0; i < n-1; i++ {
        for j := 0; j < n-1; j++ {
            maxVal := 0
            for x := i; x < i+2; x++ {
                for y := j; y < j+2; y++ {
                    if grid[x][y] > maxVal {
                        maxVal = grid[x][y]
                    }
                }
            }
            result[i][j] = maxVal
        }
    }
    return result
}
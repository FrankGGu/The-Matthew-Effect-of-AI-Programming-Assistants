package main

func matrixScore(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])

    // Flip rows to make the first column all 1s
    for i := 0; i < rows; i++ {
        if grid[i][0] == 0 {
            for j := 0; j < cols; j++ {
                grid[i][j] ^= 1
            }
        }
    }

    // Count the number of 1s in each column
    for j := 1; j < cols; j++ {
        count := 0
        for i := 0; i < rows; i++ {
            count += grid[i][j]
        }
        if count < rows-count {
            // Flip the column
            for i := 0; i < rows; i++ {
                grid[i][j] ^= 1
            }
        }
    }

    // Calculate the score
    score := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            score += grid[i][j] << (cols - 1 - j)
        }
    }

    return score
}
package main

func countUnguardedCells(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    directions := [4][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    isGuarded := make([][]bool, rows)
    for i := range isGuarded {
        isGuarded[i] = make([]bool, cols)
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                for _, dir := range directions {
                    ni, nj := i+dir[0], j+dir[1]
                    for ni >= 0 && ni < rows && nj >= 0 && nj < cols {
                        if grid[ni][nj] == 1 {
                            break
                        }
                        isGuarded[ni][nj] = true
                        ni += dir[0]
                        nj += dir[1]
                    }
                }
            }
        }
    }

    count := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if !isGuarded[i][j] && grid[i][j] != 1 {
                count++
            }
        }
    }
    return count
}
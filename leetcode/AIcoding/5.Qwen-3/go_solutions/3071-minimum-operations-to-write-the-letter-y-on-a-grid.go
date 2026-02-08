package main

func minimumOperationsToWriteY(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    yPositions := make(map[[2]int]bool)

    // Mark positions that form the letter Y
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if i == 0 && j == cols/2 {
                yPositions[[2]int{i, j}] = true
            } else if i > 0 && i <= rows/2 && (j == 0 || j == cols-1) {
                yPositions[[2]int{i, j}] = true
            } else if i > rows/2 && j == cols/2 {
                yPositions[[2]int{i, j}] = true
            }
        }
    }

    count := make(map[int]int)
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            count[grid[i][j]]++
        }
    }

    yCount := make(map[int]int)
    for pos := range yPositions {
        yCount[grid[pos[0]][pos[1]]]++
    }

    minOps := 1e9
    for target := 0; target <= 9; target++ {
        ops := 0
        for k := 0; k <= 9; k++ {
            if k == target {
                continue
            }
            ops += (count[k] - yCount[k]) * 1
        }
        minOps = min(minOps, ops)
    }

    return minOps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
package main

func largestMagicSquare(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])
    maxSize := 1

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for k := 1; i+k < m && j+k < n; k++ {
                if isMagic(grid, i, j, k) {
                    maxSize = k + 1
                }
            }
        }
    }

    return maxSize
}

func isMagic(grid [][]int, x, y, size int) bool {
    rowSum := make(map[int]int)
    colSum := make(map[int]int)
    diag1 := 0
    diag2 := 0

    for i := 0; i <= size; i++ {
        for j := 0; j <= size; j++ {
            if i == 0 || i == size {
                rowSum[x+i] += grid[x+i][y+j]
            }
            if j == 0 || j == size {
                colSum[y+j] += grid[x+i][y+j]
            }
            if i == j {
                diag1 += grid[x+i][y+j]
            }
            if i + j == size {
                diag2 += grid[x+i][y+j]
            }
        }
    }

    if diag1 != diag2 {
        return false
    }

    for _, s := range rowSum {
        if s != diag1 {
            return false
        }
    }

    for _, s := range colSum {
        if s != diag1 {
            return false
        }
    }

    return true
}
func largestMagicSquare(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    maxSize := 0

    for size := 1; size <= min(rows, cols); size++ {
        for r := 0; r <= rows-size; r++ {
            for c := 0; c <= cols-size; c++ {
                if isMagicSquare(grid, r, c, size) {
                    maxSize = size
                }
            }
        }
    }

    return maxSize
}

func isMagicSquare(grid [][]int, r, c, size int) bool {
    sum := 0
    for i := 0; i < size; i++ {
        sum += grid[r][c+i]
    }

    for i := 0; i < size; i++ {
        rowSum := 0
        for j := 0; j < size; j++ {
            rowSum += grid[r+i][c+j]
        }
        if rowSum != sum {
            return false
        }
    }

    for j := 0; j < size; j++ {
        colSum := 0
        for i := 0; i < size; i++ {
            colSum += grid[r+i][c+j]
        }
        if colSum != sum {
            return false
        }
    }

    diag1, diag2 := 0, 0
    for i := 0; i < size; i++ {
        diag1 += grid[r+i][c+i]
        diag2 += grid[r+i][c+size-i-1]
    }
    return diag1 == sum && diag2 == sum
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
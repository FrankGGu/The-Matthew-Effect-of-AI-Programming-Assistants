func largestMagicSquare(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    rowSum := make([][]int, m)
    colSum := make([][]int, m)
    diag1Sum := make([][]int, m)
    diag2Sum := make([][]int, m)

    for i := 0; i < m; i++ {
        rowSum[i] = make([]int, n)
        colSum[i] = make([]int, n)
        diag1Sum[i] = make([]int, n)
        diag2Sum[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            rowSum[i][j] = grid[i][j]
            colSum[i][j] = grid[i][j]
            diag1Sum[i][j] = grid[i][j]
            diag2Sum[i][j] = grid[i][j]

            if j > 0 {
                rowSum[i][j] += rowSum[i][j-1]
            }
            if i > 0 {
                colSum[i][j] += colSum[i-1][j]
            }
            if i > 0 && j > 0 {
                diag1Sum[i][j] += diag1Sum[i-1][j-1]
            }
            if i > 0 && j < n-1 {
                diag2Sum[i][j] += diag2Sum[i-1][j+1]
            }
        }
    }

    maxK := 1
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            maxPossible := min(m - i, n - j)
            for k := maxPossible; k > maxK; k-- {
                if isMagicSquare(grid, i, j, k, rowSum, colSum, diag1Sum, diag2Sum) {
                    maxK = k
                    break
                }
            }
        }
    }
    return maxK
}

func isMagicSquare(grid [][]int, x, y, k int, rowSum, colSum, diag1Sum, diag2Sum [][]int) bool {
    diag1 := diag1Sum[x+k-1][y+k-1]
    if x > 0 && y > 0 {
        diag1 -= diag1Sum[x-1][y-1]
    }

    diag2 := diag2Sum[x+k-1][y]
    if x > 0 && y + k < len(grid[0]) {
        diag2 -= diag2Sum[x-1][y+k]
    }

    if diag1 != diag2 {
        return false
    }

    target := diag1

    for i := x; i < x + k; i++ {
        sum := rowSum[i][y + k - 1]
        if y > 0 {
            sum -= rowSum[i][y - 1]
        }
        if sum != target {
            return false
        }
    }

    for j := y; j < y + k; j++ {
        sum := colSum[x + k - 1][j]
        if x > 0 {
            sum -= colSum[x - 1][j]
        }
        if sum != target {
            return false
        }
    }

    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
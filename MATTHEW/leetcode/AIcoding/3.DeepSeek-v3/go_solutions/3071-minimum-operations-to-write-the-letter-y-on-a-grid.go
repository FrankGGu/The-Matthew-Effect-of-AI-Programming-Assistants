func minimumOperationsToWriteY(grid [][]int) int {
    n := len(grid)
    yCount := make([]int, 3)
    nonYCount := make([]int, 3)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if isYCell(i, j, n) {
                yCount[grid[i][j]]++
            } else {
                nonYCount[grid[i][j]]++
            }
        }
    }

    minOps := math.MaxInt32
    for yVal := 0; yVal < 3; yVal++ {
        for nonYVal := 0; nonYVal < 3; nonYVal++ {
            if yVal == nonYVal {
                continue
            }
            ops := 0
            for k := 0; k < 3; k++ {
                if k != yVal {
                    ops += yCount[k]
                }
                if k != nonYVal {
                    ops += nonYCount[k]
                }
            }
            if ops < minOps {
                minOps = ops
            }
        }
    }
    return minOps
}

func isYCell(i, j, n int) bool {
    if i == j && i <= n/2 {
        return true
    }
    if i + j == n-1 && i <= n/2 {
        return true
    }
    if i > n/2 && j == n/2 {
        return true
    }
    return false
}
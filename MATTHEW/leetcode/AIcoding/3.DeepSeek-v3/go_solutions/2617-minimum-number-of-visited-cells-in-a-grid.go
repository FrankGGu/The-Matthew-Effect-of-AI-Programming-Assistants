func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func minimumVisitedCells(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    if m == 1 && n == 1 {
        return 1
    }

    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = -1
        }
    }
    dist[0][0] = 1

    rowMax := make([]int, m)
    colMax := make([]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 || dist[i][j] == -1 {
                continue
            }

            maxStep := grid[i][j]
            startRow, endRow := i+1, min(i+maxStep, m-1)
            startCol, endCol := j+1, min(j+maxStep, n-1)

            if rowMax[i] < j {
                for k := max(rowMax[i]+1, startCol); k <= endCol; k++ {
                    if dist[i][k] == -1 || dist[i][j]+1 < dist[i][k] {
                        dist[i][k] = dist[i][j] + 1
                        if i == m-1 && k == n-1 {
                            return dist[i][k]
                        }
                    }
                }
                rowMax[i] = endCol
            }

            if colMax[j] < i {
                for k := max(colMax[j]+1, startRow); k <= endRow; k++ {
                    if dist[k][j] == -1 || dist[i][j]+1 < dist[k][j] {
                        dist[k][j] = dist[i][j] + 1
                        if k == m-1 && j == n-1 {
                            return dist[k][j]
                        }
                    }
                }
                colMax[j] = endRow
            }
        }
    }

    return dist[m-1][n-1]
}
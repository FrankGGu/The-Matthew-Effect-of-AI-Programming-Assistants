func possibleToStamp(grid [][]int, stampHeight int, stampWidth int) bool {
    m, n := len(grid), len(grid[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }

    for i := 0; i < m; i++ {
        rowSum := 0
        for j := 0; j < n; j++ {
            rowSum += grid[i][j]
            prefix[i+1][j+1] = prefix[i][j+1] + rowSum
        }
    }

    diff := make([][]int, m+2)
    for i := range diff {
        diff[i] = make([]int, n+2)
    }

    for i := 0; i <= m-stampHeight; i++ {
        for j := 0; j <= n-stampWidth; j++ {
            x, y := i+stampHeight, j+stampWidth
            sum := prefix[x][y] - prefix[i][y] - prefix[x][j] + prefix[i][j]
            if sum == 0 {
                diff[i+1][j+1]++
                diff[i+1][y+1]--
                diff[x+1][j+1]--
                diff[x+1][y+1]++
            }
        }
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            diff[i][j] += diff[i-1][j] + diff[i][j-1] - diff[i-1][j-1]
            if grid[i-1][j-1] == 0 && diff[i][j] == 0 {
                return false
            }
        }
    }

    return true
}
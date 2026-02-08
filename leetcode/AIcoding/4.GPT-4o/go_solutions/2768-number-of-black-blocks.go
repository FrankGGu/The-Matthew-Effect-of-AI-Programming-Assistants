func countBlackBlocks(m int, n int, coordinates [][]int) int {
    grid := make([][]int, m)
    for i := range grid {
        grid[i] = make([]int, n)
    }

    for _, coord := range coordinates {
        grid[coord[0]][coord[1]] = 1
    }

    count := make([]int, 5)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                for di := 0; di <= 1; di++ {
                    for dj := 0; dj <= 1; dj++ {
                        if i+di < m && j+dj < n {
                            blockSize := (di + 1) * (dj + 1)
                            count[blockSize]++
                        }
                    }
                }
            }
        }
    }

    for i := 1; i <= 4; i++ {
        count[i] = count[i] - count[i-1]
    }

    return count[1]
}
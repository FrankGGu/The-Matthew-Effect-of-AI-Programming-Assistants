func minArea(grid [][]byte, x int, y int) int {
    minX, maxX := x, x
    minY, maxY := y, y

    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == '1' {
                if i < minX {
                    minX = i
                }
                if i > maxX {
                    maxX = i
                }
                if j < minY {
                    minY = j
                }
                if j > maxY {
                    maxY = j
                }
            }
        }
    }

    return (maxX - minX + 1) * (maxY - minY + 1)
}
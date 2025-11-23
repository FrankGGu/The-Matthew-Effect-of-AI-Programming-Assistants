func findTreasure(grid [][]byte) []int {
    directions := [][]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
    maxGold := 0
    startX, startY := -1, -1

    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 'S' {
                startX, startY = i, j
            }
        }
    }

    var dfs func(x, y, gold int)
    dfs = func(x, y, gold int) {
        if x < 0 || x >= len(grid) || y < 0 || y >= len(grid[0]) || grid[x][y] == 'X' {
            return
        }
        if grid[x][y] == 'G' {
            gold++
        }
        temp := grid[x][y]
        grid[x][y] = 'X'
        for _, d := range directions {
            dfs(x+d[0], y+d[1], gold)
        }
        grid[x][y] = temp
        if gold > maxGold {
            maxGold = gold
        }
    }

    dfs(startX, startY, 0)
    return []int{maxGold}
}
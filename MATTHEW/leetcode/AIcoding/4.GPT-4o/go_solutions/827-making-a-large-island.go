func largestIsland(grid [][]int) int {
    n := len(grid)
    area := make(map[int]int)
    index := 2
    directions := []struct{ dx, dy int }{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    var dfs func(x, y int, idx int) int
    dfs = func(x, y int, idx int) int {
        if x < 0 || x >= n || y < 0 || y >= n || grid[x][y] != 1 {
            return 0
        }
        grid[x][y] = idx
        count := 1
        for _, d := range directions {
            count += dfs(x+d.dx, y+d.dy, idx)
        }
        return count
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                area[index] = dfs(i, j, index)
                index++
            }
        }
    }

    maxArea := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                seen := make(map[int]struct{})
                total := 1
                for _, d := range directions {
                    ni, nj := i+d.dx, j+d.dy
                    if ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] > 1 {
                        if _, ok := seen[grid[ni][nj]]; !ok {
                            total += area[grid[ni][nj]]
                            seen[grid[ni][nj]] = struct{}{}
                        }
                    }
                }
                maxArea = max(maxArea, total)
            }
        }
    }

    if maxArea == 0 {
        return n * n
    }

    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
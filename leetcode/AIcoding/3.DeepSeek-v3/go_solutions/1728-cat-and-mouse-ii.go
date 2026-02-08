func canMouseWin(grid []string, catJump int, mouseJump int) bool {
    m := len(grid)
    n := len(grid[0])
    var cx, cy, mx, my, fx, fy int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 'C' {
                cx, cy = i, j
            } else if grid[i][j] == 'M' {
                mx, my = i, j
            } else if grid[i][j] == 'F' {
                fx, fy = i, j
            }
        }
    }

    memo := make(map[[6]int]bool)
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    var dfs func(turn, cx, cy, mx, my int) bool
    dfs = func(turn, cx, cy, mx, my int) bool {
        if turn >= 100 {
            return false
        }
        key := [6]int{turn, cx, cy, mx, my}
        if v, ok := memo[key]; ok {
            return v
        }
        if turn % 2 == 0 {
            for _, d := range dirs {
                for j := 0; j <= mouseJump; j++ {
                    nx := mx + d[0] * j
                    ny := my + d[1] * j
                    if nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == '#' {
                        break
                    }
                    if nx == fx && ny == fy {
                        memo[key] = true
                        return true
                    }
                    if nx == cx && ny == cy {
                        continue
                    }
                    if !dfs(turn + 1, cx, cy, nx, ny) {
                        memo[key] = true
                        return true
                    }
                }
            }
            memo[key] = false
            return false
        } else {
            for _, d := range dirs {
                for j := 0; j <= catJump; j++ {
                    nx := cx + d[0] * j
                    ny := cy + d[1] * j
                    if nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == '#' {
                        break
                    }
                    if nx == fx && ny == fy {
                        memo[key] = false
                        return false
                    }
                    if nx == mx && ny == my {
                        memo[key] = false
                        return false
                    }
                    if !dfs(turn + 1, nx, ny, mx, my) {
                        memo[key] = false
                        return false
                    }
                }
            }
            memo[key] = true
            return true
        }
    }

    return dfs(0, cx, cy, mx, my)
}
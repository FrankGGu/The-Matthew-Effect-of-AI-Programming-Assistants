package main

type State struct {
    x, y, keys int
}

func shortestPathAllKeys(grid []string, n int, m int) int {
    from := make([][]int, n)
    for i := range from {
        from[i] = make([]int, m)
    }
    var q []State
    var keyCount int
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == '@' {
                q = append(q, State{i, j, 0})
            } else if grid[i][j] >= 'a' && grid[i][j] <= 'f' {
                keyCount++
            }
        }
    }
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make(map[string]bool)
    for len(q) > 0 {
        size := len(q)
        for i := 0; i < size; i++ {
            s := q[0]
            q = q[1:]
            if s.keys == (1 << keyCount) - 1 {
                return from[s.x][s.y]
            }
            for _, d := range directions {
                nx, ny := s.x + d[0], s.y + d[1]
                if nx >= 0 && nx < n && ny >= 0 && ny < m {
                    c := grid[nx][ny]
                    if c >= 'A' && c <= 'F' {
                        if (s.keys & (1 << (c - 'A'))) == 0 {
                            continue
                        }
                    }
                    newKeys := s.keys
                    if c >= 'a' && c <= 'f' {
                        newKeys |= 1 << (c - 'a')
                    }
                    key := fmt.Sprintf("%d,%d,%d", nx, ny, newKeys)
                    if !visited[key] {
                        visited[key] = true
                        from[nx][ny] = from[s.x][s.y] + 1
                        q = append(q, State{nx, ny, newKeys})
                    }
                }
            }
        }
    }
    return -1
}
type State struct {
    i, j, keys int
}

func shortestPathAllKeys(grid []string) int {
    m, n := len(grid), len(grid[0])
    var startI, startJ int
    keyCount := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == '@' {
                startI, startJ = i, j
            } else if grid[i][j] >= 'a' && grid[i][j] <= 'z' {
                keyCount++
            }
        }
    }

    targetKeys := (1 << keyCount) - 1
    visited := make(map[State]bool)
    queue := []State{{startI, startJ, 0}}
    visited[State{startI, startJ, 0}] = true
    steps := 0
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    for len(queue) > 0 {
        size := len(queue)
        for k := 0; k < size; k++ {
            curr := queue[k]
            if curr.keys == targetKeys {
                return steps
            }
            for _, dir := range dirs {
                ni, nj := curr.i + dir[0], curr.j + dir[1]
                if ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] != '#' {
                    c := grid[ni][nj]
                    newKeys := curr.keys
                    if c >= 'a' && c <= 'z' {
                        newKeys |= 1 << (c - 'a')
                    }
                    if c >= 'A' && c <= 'Z' {
                        if (curr.keys & (1 << (c - 'A'))) == 0 {
                            continue
                        }
                    }
                    newState := State{ni, nj, newKeys}
                    if !visited[newState] {
                        visited[newState] = true
                        queue = append(queue, newState)
                    }
                }
            }
        }
        queue = queue[size:]
        steps++
    }
    return -1
}
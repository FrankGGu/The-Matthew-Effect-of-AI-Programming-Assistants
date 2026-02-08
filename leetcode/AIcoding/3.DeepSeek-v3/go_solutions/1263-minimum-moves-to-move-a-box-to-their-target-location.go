type State struct {
    boxX, boxY int
    playerX, playerY int
}

func minPushBox(grid [][]byte) int {
    m, n := len(grid), len(grid[0])
    var boxX, boxY, targetX, targetY, playerX, playerY int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 'B' {
                boxX, boxY = i, j
            } else if grid[i][j] == 'T' {
                targetX, targetY = i, j
            } else if grid[i][j] == 'S' {
                playerX, playerY = i, j
            }
        }
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make(map[State]bool)
    queue := []State{{boxX, boxY, playerX, playerY}}
    visited[State{boxX, boxY, playerX, playerY}] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[i]
            if current.boxX == targetX && current.boxY == targetY {
                return steps
            }

            for _, dir := range dirs {
                newPlayerX, newPlayerY := current.playerX+dir[0], current.playerY+dir[1]
                if newPlayerX < 0 || newPlayerX >= m || newPlayerY < 0 || newPlayerY >= n || grid[newPlayerX][newPlayerY] == '#' {
                    continue
                }

                if newPlayerX == current.boxX && newPlayerY == current.boxY {
                    newBoxX, newBoxY := current.boxX+dir[0], current.boxY+dir[1]
                    if newBoxX < 0 || newBoxX >= m || newBoxY < 0 || newBoxY >= n || grid[newBoxX][newBoxY] == '#' {
                        continue
                    }
                    newState := State{newBoxX, newBoxY, newPlayerX, newPlayerY}
                    if !visited[newState] {
                        visited[newState] = true
                        queue = append(queue, newState)
                    }
                } else {
                    newState := State{current.boxX, current.boxY, newPlayerX, newPlayerY}
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
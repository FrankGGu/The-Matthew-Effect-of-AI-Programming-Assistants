type State struct {
    x, y, dir int
}

func minimumMoves(grid [][]int) int {
    n := len(grid)
    visited := make(map[State]bool)
    queue := []State{{0, 0, 0}}
    visited[State{0, 0, 0}] = true
    moves := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[i]
            if current.x == n-1 && current.y == n-2 && current.dir == 0 {
                return moves
            }

            if current.dir == 0 {
                if current.y+2 < n && grid[current.x][current.y+2] == 0 {
                    next := State{current.x, current.y + 1, 0}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
                if current.x+1 < n && grid[current.x+1][current.y] == 0 && grid[current.x+1][current.y+1] == 0 {
                    next := State{current.x + 1, current.y, 0}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                    next = State{current.x, current.y, 1}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
            } else {
                if current.x+2 < n && grid[current.x+2][current.y] == 0 {
                    next := State{current.x + 1, current.y, 1}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
                if current.y+1 < n && grid[current.x][current.y+1] == 0 && grid[current.x+1][current.y+1] == 0 {
                    next := State{current.x, current.y + 1, 1}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                    next = State{current.x, current.y, 0}
                    if !visited[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
            }
        }
        queue = queue[size:]
        moves++
    }
    return -1
}
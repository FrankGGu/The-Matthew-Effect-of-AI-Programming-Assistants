func escapeMaze(maze [][]string) bool {
    m := len(maze)
    if m == 0 {
        return false
    }
    n := len(maze[0])
    if n == 0 {
        return false
    }

    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    visited := make([][][][]bool, m)
    for i := range visited {
        visited[i] = make([][][]bool, n)
        for j := range visited[i] {
            visited[i][j] = make([][]bool, 2)
            for k := range visited[i][j] {
                visited[i][j][k] = make([]bool, 2)
            }
        }
    }

    queue := [][5]int{{0, 0, 0, 0, 0}}
    visited[0][0][0][0] = true

    for len(queue) > 0 {
        cur := queue[0]
        queue = queue[1:]
        i, j, t, usedTemp, usedPerm := cur[0], cur[1], cur[2], cur[3], cur[4]

        if i == m-1 && j == n-1 {
            return true
        }

        if t >= len(maze)-1 {
            continue
        }

        for _, d := range dirs {
            ni, nj := i+d[0], j+d[1]
            if ni < 0 || ni >= m || nj < 0 || nj >= n {
                continue
            }

            if maze[t+1][ni][nj] == '.' {
                if !visited[ni][nj][usedTemp][usedPerm] {
                    visited[ni][nj][usedTemp][usedPerm] = true
                    queue = append(queue, [5]int{ni, nj, t + 1, usedTemp, usedPerm})
                }
            } else {
                if usedTemp == 0 && !visited[ni][nj][1][usedPerm] {
                    visited[ni][nj][1][usedPerm] = true
                    queue = append(queue, [5]int{ni, nj, t + 1, 1, usedPerm})
                }
                if usedPerm == 0 && !visited[ni][nj][usedTemp][1] {
                    visited[ni][nj][usedTemp][1] = true
                    queue = append(queue, [5]int{ni, nj, t + 1, usedTemp, 1})
                }
            }
        }

        if !visited[i][j][usedTemp][usedPerm] {
            visited[i][j][usedTemp][usedPerm] = true
            queue = append(queue, [5]int{i, j, t + 1, usedTemp, usedPerm})
        }
    }

    return false
}
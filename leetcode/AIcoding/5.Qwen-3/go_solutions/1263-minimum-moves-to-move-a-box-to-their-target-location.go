package main

func minMovesToBoxToTarget(grid [][]byte) int {
    m, n := len(grid), len(grid[0])
    var player, box, target [2]int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 'S' {
                player = [2]int{i, j}
            } else if grid[i][j] == 'B' {
                box = [2]int{i, j}
            } else if grid[i][j] == 'T' {
                target = [2]int{i, j}
            }
        }
    }

    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make(map[[3]int]bool)

    queue := [][4]int{{player[0], player[1], box[0], box[1], 0}}
    for len(queue) > 0 {
        q := queue[0]
        queue = queue[1:]
        px, py, bx, by, moves := q[0], q[1], q[2], q[3], q[4]
        if bx == target[0] && by == target[1] {
            return moves
        }
        if visited[[3]int{px, py, bx, by}] {
            continue
        }
        visited[[3]int{px, py, bx, by}] = true

        for _, d := range directions {
            nx, ny := px+d[0], py+d[1]
            if nx >= 0 && ny >= 0 && nx < m && ny < n && grid[nx][ny] != '#' {
                if nx == bx && ny == by {
                    bx2, by2 := bx+d[0], by+d[1]
                    if bx2 >= 0 && by2 >= 0 && bx2 < m && by2 < n && grid[bx2][by2] != '#' {
                        queue = append(queue, [4]int{nx, ny, bx2, by2, moves + 1})
                    }
                } else {
                    queue = append(queue, [4]int{nx, ny, bx, by, moves + 1})
                }
            }
        }
    }
    return -1
}
package main

func maximumMinutes(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    var bfs func([][]int, [][2]int) [][]int
    bfs = func(grid [][]int, starts [][2]int) [][]int {
        dist := make([][]int, m)
        for i := range dist {
            dist[i] = make([]int, n)
            for j := range dist[i] {
                dist[i][j] = -1
            }
        }
        q := [][2]int{}
        for _, start := range starts {
            dist[start[0]][start[1]] = 0
            q = append(q, start)
        }
        for len(q) > 0 {
            size := len(q)
            for i := 0; i < size; i++ {
                x, y := q[0][0], q[0][1]
                q = q[1:]
                for _, d := range dirs {
                    nx, ny := x+d[0], y+d[1]
                    if nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 && dist[nx][ny] == -1 {
                        dist[nx][ny] = dist[x][y] + 1
                        q = append(q, [2]int{nx, ny})
                    }
                }
            }
        }
        return dist
    }

    fireDist := bfs(grid, [][2]int{})
    personDist := bfs(grid, [][2]int{{0, 0}})

    if personDist[m-1][n-1] == -1 {
        return -1
    }

    if fireDist[m-1][n-1] == -1 {
        return 10^9
    }

    if personDist[m-1][n-1] < fireDist[m-1][n-1] {
        return 10^9
    }

    if personDist[m-1][n-1] == fireDist[m-1][n-1] {
        return 0
    }

    return personDist[m-1][n-1] - fireDist[m-1][n-1]
}
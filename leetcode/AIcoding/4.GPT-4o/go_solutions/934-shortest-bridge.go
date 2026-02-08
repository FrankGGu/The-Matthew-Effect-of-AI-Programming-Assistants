func shortestBridge(A [][]int) int {
    directions := []struct{ x, y int }{
        {1, 0}, {0, 1}, {-1, 0}, {0, -1},
    }

    var dfs func(x, y int)
    dfs = func(x, y int) {
        if x < 0 || y < 0 || x >= len(A) || y >= len(A[0]) || A[x][y] != 1 {
            return
        }
        A[x][y] = 2
        for _, d := range directions {
            dfs(x+d.x, y+d.y)
        }
    }

    var bfs [][]int
    found := false
    for i := 0; i < len(A); i++ {
        for j := 0; j < len(A[0]); j++ {
            if A[i][j] == 1 {
                dfs(i, j)
                found = true
                break
            }
        }
        if found {
            break
        }
    }

    for i := 0; i < len(A); i++ {
        for j := 0; j < len(A[0]); j++ {
            if A[i][j] == 2 {
                bfs = append(bfs, []int{i, j})
            }
        }
    }

    dist := 0
    for len(bfs) > 0 {
        nextBfs := [][]int{}
        for _, p := range bfs {
            for _, d := range directions {
                x, y := p[0]+d.x, p[1]+d.y
                if x < 0 || y < 0 || x >= len(A) || y >= len(A[0]) {
                    continue
                }
                if A[x][y] == 1 {
                    return dist
                }
                if A[x][y] == 0 {
                    A[x][y] = 2
                    nextBfs = append(nextBfs, []int{x, y})
                }
            }
        }
        bfs = nextBfs
        dist++
    }

    return -1
}
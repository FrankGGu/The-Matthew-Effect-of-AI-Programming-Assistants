func domino(n int, m int, broken [][]int) int {
    graph := make([][]bool, n)
    for i := range graph {
        graph[i] = make([]bool, m)
    }
    for _, b := range broken {
        graph[b[0]][b[1]] = true
    }

    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    match := make([][]int, n)
    for i := range match {
        match[i] = make([]int, m)
        for j := range match[i] {
            match[i][j] = -1
        }
    }

    var dfs func(u, v int, visited [][]bool) bool
    dfs = func(u, v int, visited [][]bool) bool {
        for _, d := range dirs {
            x, y := u+d[0], v+d[1]
            if x >= 0 && x < n && y >= 0 && y < m && !graph[x][y] && !visited[x][y] {
                visited[x][y] = true
                if match[x][y] == -1 || dfs(match[x][y]/m, match[x][y]%m, visited) {
                    match[x][y] = u*m + v
                    return true
                }
            }
        }
        return false
    }

    res := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if (i+j)%2 == 0 && !graph[i][j] {
                visited := make([][]bool, n)
                for k := range visited {
                    visited[k] = make([]bool, m)
                }
                if dfs(i, j, visited) {
                    res++
                }
            }
        }
    }
    return res
}
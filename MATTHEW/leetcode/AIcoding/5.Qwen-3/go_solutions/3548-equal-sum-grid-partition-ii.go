package main

func isPossible(grid [][]int, k int) bool {
    n := len(grid)
    m := len(grid[0])

    sum := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            sum += grid[i][j]
        }
    }

    if sum%k != 0 {
        return false
    }

    target := sum / k

    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, m)
    }

    var dfs func(i, j, current int) bool
    dfs = func(i, j, current int) bool {
        if current == target {
            return true
        }
        if current > target {
            return false
        }

        visited[i][j] = true

        directions := [4][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            if ni >= 0 && ni < n && nj >= 0 && nj < m && !visited[ni][nj] {
                if dfs(ni, nj, current+grid[ni][nj]) {
                    return true
                }
            }
        }

        visited[i][j] = false
        return false
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if dfs(i, j, grid[i][j]) {
                k--
                if k == 0 {
                    return true
                }
            }
        }
    }

    return false
}
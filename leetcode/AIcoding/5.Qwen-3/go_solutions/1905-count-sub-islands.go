package main

func countSubIslands(grid1 [][]int, grid2 [][]int) int {
    m, n := len(grid2), len(grid2[0])
    directions := [][]int{{0, 1}, {1, 0}, {-1, 0}, {0, -1}}
    var dfs func(i, j int) bool
    dfs = func(i, j int) bool {
        if i < 0 || j < 0 || i >= m || j >= n || grid2[i][j] == 0 {
            return true
        }
        grid2[i][j] = 0
        isSub := true
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            if !dfs(ni, nj) {
                isSub = false
            }
        }
        return isSub
    }
    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid2[i][j] == 1 && dfs(i, j) {
                count++
            }
        }
    }
    return count
}
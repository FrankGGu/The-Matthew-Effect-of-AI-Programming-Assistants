package main

func findPaths(m int, n int, maxMove int, startRow int, startCol int) int {
    mod := 1000000007
    memo := make([][][]int, m)
    for i := range memo {
        memo[i] = make([][]int, n)
        for j := range memo[i] {
            memo[i][j] = make([]int, maxMove+1)
        }
    }

    var dfs func(i, j, move int) int
    dfs = func(i, j, move int) int {
        if i < 0 || j < 0 || i >= m || j >= n {
            return 1
        }
        if move == 0 {
            return 0
        }
        if memo[i][j][move] != 0 {
            return memo[i][j][move]
        }
        res := 0
        directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            res = (res + dfs(ni, nj, move-1)) % mod
        }
        memo[i][j][move] = res
        return res
    }

    return dfs(startRow, startCol, maxMove)
}
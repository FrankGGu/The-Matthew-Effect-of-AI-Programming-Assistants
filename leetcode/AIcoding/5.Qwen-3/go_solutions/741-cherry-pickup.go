package main

func cherryPickup(grid [][]int) int {
    n := len(grid)
    memo := make([][][]int, n)
    for i := range memo {
        memo[i] = make([][]int, n)
        for j := range memo[i] {
            memo[i][j] = make([]int, n)
            for k := range memo[i][j] {
                memo[i][j][k] = -1
            }
        }
    }
    var dp func(int, int, int) int
    dp = func(r1, c1, c2 int) int {
        r2 := r1 + c1 - c2
        if r1 >= n || c1 >= n || r2 >= n || c2 >= n {
            return -1
        }
        if grid[r1][c1] == -1 || grid[r2][c2] == -1 {
            return -1
        }
        if r1 == n-1 && c1 == n-1 {
            return grid[r1][c1]
        }
        if memo[r1][c1][c2] != -1 {
            return memo[r1][c1][c2]
        }
        res := 0
        if r1 == r2 && c1 == c2 {
            res = grid[r1][c1]
        } else {
            res = grid[r1][c1] + grid[r2][c2]
        }
        maxNext := 0
        for dr1 := 0; dr1 <= 1; dr1++ {
            for dr2 := 0; dr2 <= 1; dr2++ {
                next := dp(r1+dr1, c1+1, c2+dr2)
                if next > maxNext {
                    maxNext = next
                }
            }
        }
        if maxNext == -1 {
            memo[r1][c1][c2] = -1
        } else {
            memo[r1][c1][c2] = res + maxNext
        }
        return memo[r1][c1][c2]
    }
    result := dp(0, 0, 0)
    if result < 0 {
        return 0
    }
    return result
}
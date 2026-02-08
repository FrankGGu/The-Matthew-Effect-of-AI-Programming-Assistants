package main

const MOD int = 1_000_000_007

var dr = []int{-1, 1, 0, 0}
var dc = []int{0, 0, -1, 1}

var memo [][]int
var R, C int
var Grid [][]int

func dfs(r, c int) int {
	if memo[r][c] != -1 {
		return memo[r][c]
	}

	count := 1 

	for i := 0; i < 4; i++ {
		nr, nc := r+dr[i], c+dc[i]

		if nr >= 0 && nr < R && nc >= 0 && nc < C && Grid[nr][nc] > Grid[r][c] {
			count = (count + dfs(nr, nc)) % MOD
		}
	}

	memo[r][c] = count
	return count
}

func countPaths(grid [][]int) int {
	Grid = grid 
	R = len(grid)
	C = len(grid[0])

	memo = make([][]int, R)
	for i := range memo {
		memo[i] = make([]int, C)
		for j := range memo[i] {
			memo[i][j] = -1 
		}
	}

	totalPaths := 0
	for r := 0; r < R; r++ {
		for c := 0; c < C; c++ {
			totalPaths = (totalPaths + dfs(r, c)) % MOD
		}
	}

	return totalPaths
}
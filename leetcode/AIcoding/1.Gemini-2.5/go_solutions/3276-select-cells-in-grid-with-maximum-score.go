package main

import (
	"sort"
)

type Cell struct {
	r, c, val int
}

func maxScore(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	cells := make([]Cell, 0, m*n)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			cells = append(cells, Cell{r: r, c: c, val: grid[r][c]})
		}
	}

	sort.Slice(cells, func(i, j int) bool {
		return cells[i].val < cells[j].val
	})

	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = grid[i][j]
		}
	}

	maxScoreVal := 0

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for _, cell := range cells {
		r, c, val := cell.r, cell.c, cell.val

		if val-dp[r][c] > maxScoreVal {
			maxScoreVal = val - dp[r][c]
		}

		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				if grid[nr][nc] > val {
					if dp[r][c] < dp[nr][nc] {
						dp[nr][nc] = dp[r][c]
					}
				}
			}
		}
	}

	return maxScoreVal
}
package main

import (
	"sort"
)

type Cell struct {
	val int
	r   int
	c   int
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func longestIncreasingPath(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	cells := make([]Cell, 0, m*n)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			cells = append(cells, Cell{grid[r][c], r, c})
		}
	}

	sort.Slice(cells, func(i, j int) bool {
		return cells[i].val < cells[j].val
	})

	rowMaxLen := make([]int, m)
	colMaxLen := make([]int, n)

	ans := 0

	i := 0
	for i < len(cells) {
		j := i

		tempUpdates := make([]struct{ r, c, val int }, 0)

		for j < len(cells) && cells[j].val == cells[i].val {
			r, c := cells[j].r, cells[j].c

			currentLen := 1 + max(rowMaxLen[r], colMaxLen[c])

			tempUpdates = append(tempUpdates, struct{ r, c, val int }{r, c, currentLen})
			ans = max(ans, currentLen)
			j++
		}

		for _, update := range tempUpdates {
			rowMaxLen[update.r] = max(rowMaxLen[update.r], update.val)
			colMaxLen[update.c] = max(colMaxLen[update.c], update.val)
		}

		i = j
	}

	return ans
}
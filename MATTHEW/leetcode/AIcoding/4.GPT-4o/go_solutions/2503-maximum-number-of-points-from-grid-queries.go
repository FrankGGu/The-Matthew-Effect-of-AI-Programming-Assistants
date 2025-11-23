package main

import (
	"sort"
)

func maxPoints(grid [][]int, queries []int) []int {
	m, n := len(grid), len(grid[0])
	points := make([][]int, m)
	for i := 0; i < m; i++ {
		points[i] = make([]int, n)
	}
	points[0][0] = grid[0][0]
	for i := 1; i < m; i++ {
		points[i][0] = points[i-1][0] + grid[i][0]
	}
	for j := 1; j < n; j++ {
		points[0][j] = points[0][j-1] + grid[0][j]
	}
	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			points[i][j] = grid[i][j] + max(points[i-1][j], points[i][j-1])
		}
	}

	results := make([]int, len(queries))
	qs := make([][2]int, len(queries))
	for i, q := range queries {
		qs[i] = [2]int{q, i}
	}
	sort.Slice(qs, func(i, j int) bool {
		return qs[i][0] < qs[j][0]
	})

	currMax := 0
	for _, q := range qs {
		for currMax < m*n && points[currMax/n][currMax%n] <= q[0] {
			currMax++
		}
		results[q[1]] = currMax
	}
	return results
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
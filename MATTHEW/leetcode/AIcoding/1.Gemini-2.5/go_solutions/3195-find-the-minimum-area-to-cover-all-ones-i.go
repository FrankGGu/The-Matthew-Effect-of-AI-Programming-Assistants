package main

import "math"

func minimumArea(grid [][]byte) int {
	m := len(grid)
	n := len(grid[0])

	minR, maxR := m, -1
	minC, maxC := n, -1

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == '1' {
				if r < minR {
					minR = r
				}
				if r > maxR {
					maxR = r
				}
				if c < minC {
					minC = c
				}
				if c > maxC {
					maxC = c
				}
			}
		}
	}

	if maxR == -1 { // No '1's found
		return 0
	}

	return (maxR - minR + 1) * (maxC - minC + 1)
}
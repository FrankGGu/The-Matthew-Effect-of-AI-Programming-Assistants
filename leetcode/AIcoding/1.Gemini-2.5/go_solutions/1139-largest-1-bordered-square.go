package main

import "math"

func largest1BorderedSquare(grid [][]int) int {
	rows := len(grid)
	if rows == 0 {
		return 0
	}
	cols := len(grid[0])
	if cols == 0 {
		return 0
	}

	left := make([][]int, rows)
	up := make([][]int, rows)
	for i := range rows {
		left[i] = make([]int, cols)
		up[i] = make([]int, cols)
	}

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] == 1 {
				if c > 0 {
					left[r][c] = left[r][c-1] + 1
				} else {
					left[r][c] = 1
				}
				if r > 0 {
					up[r][c] = up[r-1][c] + 1
				} else {
					up[r][c] = 1
				}
			}
		}
	}

	maxSide := 0
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] == 0 {
				continue
			}

			currentMaxK := int(math.Min(float64(left[r][c]), float64(up[r][c])))

			for k := currentMaxK; k >= 1; k-- {
				// Check if the top border (r-k+1, c-k+1) to (r-k+1, c)
				// and left border (r-k+1, c-k+1) to (r, c-k+1) are all 1s.
				// The bottom border (r, c-k+1) to (r, c) is covered by left[r][c] >= k
				// The right border (r-k+1, c) to (r, c) is covered by up[r][c] >= k
				if left[r-k+1][c] >= k && up[r][c-k+1] >= k {
					maxSide = int(math.Max(float64(maxSide), float64(k)))
					break
				}
			}
		}
	}

	return maxSide * maxSide
}
package main

import "math"

func checkValidGrid(grid [][]int) bool {
	n := len(grid)
	totalSteps := n * n

	if grid[0][0] != 0 {
		return false
	}

	// positions[k] stores the [row, col] for step k
	positions := make([][2]int, totalSteps)

	for r := 0; r < n; r++ {
		for c := 0; c < n; c++ {
			step := grid[r][c]
			if step < 0 || step >= totalSteps {
				// This case should not happen based on constraints but good for robustness
				return false
			}
			positions[step] = [2]int{r, c}
		}
	}

	// Check if each consecutive step is a valid knight's move
	for k := 0; k < totalSteps-1; k++ {
		r1, c1 := positions[k][0], positions[k][1]
		r2, c2 := positions[k+1][0], positions[k+1][1]

		dr := int(math.Abs(float64(r1 - r2)))
		dc := int(math.Abs(float64(c1 - c2)))

		// A valid knight's move is (1, 2) or (2, 1) difference in coordinates
		if !((dr == 1 && dc == 2) || (dr == 2 && dc == 1)) {
			return false
		}
	}

	return true
}
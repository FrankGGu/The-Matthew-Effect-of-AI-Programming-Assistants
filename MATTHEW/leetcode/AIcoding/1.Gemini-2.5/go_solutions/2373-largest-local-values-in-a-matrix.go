package main

func largestLocal(grid [][]int) [][]int {
	n := len(grid)
	resultSize := n - 2
	maxLocal := make([][]int, resultSize)
	for i := range maxLocal {
		maxLocal[i] = make([]int, resultSize)
	}

	for i := 0; i < resultSize; i++ {
		for j := 0; j < resultSize; j++ {
			currentMax := 0
			// Iterate over the 3x3 submatrix
			for r := i; r < i+3; r++ {
				for c := j; c < j+3; c++ {
					if grid[r][c] > currentMax {
						currentMax = grid[r][c]
					}
				}
			}
			maxLocal[i][j] = currentMax
		}
	}

	return maxLocal
}
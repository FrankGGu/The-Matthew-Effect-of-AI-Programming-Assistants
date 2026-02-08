package main

import "math"

func findPeakGrid(mat [][]int) []int {
	m := len(mat)
	n := len(mat[0])

	lowRow := 0
	highRow := m - 1

	for lowRow <= highRow {
		midRow := lowRow + (highRow-lowRow)/2

		maxColInMidRow := 0
		for j := 1; j < n; j++ {
			if mat[midRow][j] > mat[midRow][maxColInMidRow] {
				maxColInMidRow = j
			}
		}

		currentVal := mat[midRow][maxColInMidRow]

		upVal := math.MinInt64
		if midRow > 0 {
			upVal = mat[midRow-1][maxColInMidRow]
		}

		downVal := math.MinInt64
		if midRow < m-1 {
			downVal = mat[midRow+1][maxColInMidRow]
		}

		if currentVal > upVal && currentVal > downVal {
			return []int{midRow, maxColInMidRow}
		} else if upVal > currentVal {
			highRow = midRow - 1
		} else { // downVal > currentVal
			lowRow = midRow + 1
		}
	}

	return []int{-1, -1} // Should not be reached based on problem constraints
}
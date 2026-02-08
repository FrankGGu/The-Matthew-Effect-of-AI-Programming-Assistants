package main

import (
	"sort"
)

func largestSubmatrix(matrix [][]int) int {
	m := len(matrix)
	n := len(matrix[0])

	maxArea := 0
	currentHeights := make([]int, n)

	for r := 0; r < m; r++ {
		// Calculate current heights for each column based on the current row
		// If matrix[r][c] is 1, increment the height. If 0, reset to 0.
		for c := 0; c < n; c++ {
			if matrix[r][c] == 1 {
				currentHeights[c]++
			} else {
				currentHeights[c] = 0
			}
		}

		// Create a copy of currentHeights to sort.
		// This is necessary because currentHeights needs to maintain column integrity
		// for calculations in the next row, while we need a sorted version
		// to find the maximum area for the current row.
		heightsForSorting := make([]int, n)
		copy(heightsForSorting, currentHeights)

		// Sort the heights in descending order.
		// After sorting, heightsForSorting[k] represents a potential height
		// for a submatrix that can extend across (k+1) columns.
		sort.Slice(heightsForSorting, func(i, j int) bool {
			return heightsForSorting[i] > heightsForSorting[j]
		})

		// Calculate the maximum area for the current row by iterating through sorted heights.
		for k := 0; k < n; k++ {
			// The k-th largest height (0-indexed) can form a rectangle with width (k+1).
			// For example, the largest height can form a rectangle of width 1.
			// The second largest height can form a rectangle of width 2 (because it can extend
			// under the largest height as well, since it's smaller or equal).
			area := heightsForSorting[k] * (k + 1)
			if area > maxArea {
				maxArea = area
			}
		}
	}

	return maxArea
}
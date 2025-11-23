package main

import "math"

func countSquares(matrix [][]int) int {
	m := len(matrix)
	if m == 0 {
		return 0
	}
	n := len(matrix[0])
	if n == 0 {
		return 0
	}

	count := 0

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if matrix[i][j] == 1 {
				if i == 0 || j == 0 {
					// For the first row or column, a '1' always forms a 1x1 square.
					// The value in matrix[i][j] remains 1.
				} else {
					// For other cells, if matrix[i][j] is 1, it can extend squares
					// from its top, left, and top-left neighbors.
					// The size of the largest square ending at (i,j) is 1 + the minimum
					// of the largest squares ending at (i-1,j), (i,j-1), and (i-1,j-1).
					matrix[i][j] = 1 + min(matrix[i-1][j], matrix[i][j-1], matrix[i-1][j-1])
				}
				// Each cell matrix[i][j] (after DP calculation) stores the size 'k'
				// of the largest square ending at (i,j). This 'k' also means there are
				// 'k' squares of sizes 1x1, 2x2, ..., kxk ending at (i,j).
				// So, we add this value to the total count.
				count += matrix[i][j]
			}
		}
	}

	return count
}

func min(a, b, c int) int {
	return int(math.Min(float64(a), math.Min(float64(b), float64(c))))
}
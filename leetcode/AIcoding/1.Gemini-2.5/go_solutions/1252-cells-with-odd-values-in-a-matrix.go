func oddCells(m int, n int, indices [][]int) int {
	rowCounts := make([]int, m)
	colCounts := make([]int, n)

	for _, idx := range indices {
		r, c := idx[0], idx[1]
		rowCounts[r]++
		colCounts[c]++
	}

	oddCount := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if (rowCounts[r]+colCounts[c])%2 != 0 {
				oddCount++
			}
		}
	}

	return oddCount
}
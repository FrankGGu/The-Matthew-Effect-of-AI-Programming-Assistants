func differenceOfDistinctValues(grid [][]int) [][]int {
	m := len(grid)
	n := len(grid[0])
	ans := make([][]int, m)
	for i := range ans {
		ans[i] = make([]int, n)
	}

	prefixSets := make([][]map[int]bool, m)
	suffixSets := make([][]map[int]bool, m)
	for i := range prefixSets {
		prefixSets[i] = make([]map[int]bool, n)
		suffixSets[i] = make([]map[int]bool, n)
	}

	// Calculate prefixSets: For each cell (r, c), store distinct values on the main diagonal
	// from its top-leftmost cell up to and including (r, c).
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			currentSet := make(map[int]bool)
			if r > 0 && c > 0 {
				for val := range prefixSets[r-1][c-1] {
					currentSet[val] = true
				}
			}
			currentSet[grid[r][c]] = true
			prefixSets[r][c] = currentSet
		}
	}

	// Calculate suffixSets: For each cell (r, c), store distinct values on the main diagonal
	// from (r, c) down to its bottom-rightmost cell.
	for r := m - 1; r >= 0; r-- {
		for c := n - 1; c >= 0; c-- {
			currentSet := make(map[int]bool)
			if r < m-1 && c < n-1 {
				for val := range suffixSets[r+1][c+1] {
					currentSet[val] = true
				}
			}
			currentSet[grid[r][c]] = true
			suffixSets[r][c] = currentSet
		}
	}

	// Calculate ans for each cell (r, c)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			countTL := 0
			// The top-left diagonal part for (r, c) consists of cells (i, j) where i < r, j < c, and i-j == r-c.
			// This is equivalent to the distinct values in prefixSets[r-1][c-1].
			if r > 0 && c > 0 {
				countTL = len(prefixSets[r-1][c-1])
			}

			countBR := 0
			// The bottom-right diagonal part for (r, c) consists of cells (i, j) where i > r, j > c, and i-j == r-c.
			// This is equivalent to the distinct values in suffixSets[r+1][c+1].
			if r < m-1 && c < n-1 {
				countBR = len(suffixSets[r+1][c+1])
			}

			ans[r][c] = abs(countTL - countBR)
		}
	}

	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}
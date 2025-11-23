func longestVShapedDiagonal(grid []string) int {
	m, n := len(grid), len(grid[0])
	maxLen := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == '1' {
				maxLen = max(maxLen, 1)
				for len := 2; i-len+1 >= 0 && i+len-1 < m && j-len+1 >= 0 && j+len-1 < n; len++ {
					if grid[i-len+1][j-len+1] == '1' && grid[i+len-1][j+len-1] == '1' {
						maxLen = max(maxLen, 2*len-1)
					} else {
						break
					}
				}
			}
		}
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
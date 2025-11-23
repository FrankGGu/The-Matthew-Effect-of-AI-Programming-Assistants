func maximumRows(matrix [][]int, cols int) int {
	m, n := len(matrix), len(matrix[0])
	ans := 0
	for mask := 0; mask < (1 << n); mask++ {
		if countSetBits(uint(mask)) != cols {
			continue
		}
		covered := 0
		for i := 0; i < m; i++ {
			cover := true
			for j := 0; j < n; j++ {
				if matrix[i][j] == 1 && (mask&(1<<j)) == 0 {
					cover = false
					break
				}
			}
			if cover {
				covered++
			}
		}
		ans = max(ans, covered)
	}
	return ans
}

func countSetBits(n uint) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
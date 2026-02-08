func imageSmoother(img [][]int) [][]int {
	m, n := len(img), len(img[0])
	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			sum := 0
			count := 0
			for x := max(0, i-1); x <= min(m-1, i+1); x++ {
				for y := max(0, j-1); y <= min(n-1, j+1); y++ {
					sum += img[x][y]
					count++
				}
			}
			result[i][j] = sum / count
		}
	}

	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
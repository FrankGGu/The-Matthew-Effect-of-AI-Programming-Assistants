func numSubmat(mat [][]int) int {
	m := len(mat)
	n := len(mat[0])
	height := make([][]int, m)
	for i := range height {
		height[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if mat[i][j] == 1 {
				if i == 0 {
					height[i][j] = 1
				} else {
					height[i][j] = height[i-1][j] + 1
				}
			}
		}
	}

	ans := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if mat[i][j] == 1 {
				minH := height[i][j]
				for k := j; k >= 0; k-- {
					minH = min(minH, height[i][k])
					ans += minH
				}
			}
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
func maxSideLength(mat [][]int, threshold int) int {
	m, n := len(mat), len(mat[0])
	sum := make([][]int, m+1)
	for i := 0; i <= m; i++ {
		sum[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			sum[i][j] = sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1] + mat[i-1][j-1]
		}
	}

	ans := 0
	for k := 1; k <= min(m, n); k++ {
		found := false
		for i := k; i <= m; i++ {
			for j := k; j <= n; j++ {
				s := sum[i][j] - sum[i-k][j] - sum[i][j-k] + sum[i-k][j-k]
				if s <= threshold {
					ans = k
					found = true
					break
				}
			}
			if found {
				break
			}
		}
		if !found {
			break
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
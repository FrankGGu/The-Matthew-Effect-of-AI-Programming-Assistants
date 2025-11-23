func possibleToStamp(grid [][]int, stampHeight int, stampWidth int) bool {
	m, n := len(grid), len(grid[0])
	prefixSum := make([][]int, m+1)
	for i := 0; i <= m; i++ {
		prefixSum[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			prefixSum[i][j] = prefixSum[i-1][j] + prefixSum[i][j-1] - prefixSum[i-1][j-1] + grid[i-1][j-1]
		}
	}

	diff := make([][]int, m)
	for i := 0; i < m; i++ {
		diff[i] = make([]int, n)
	}

	for i := 0; i <= m-stampHeight; i++ {
		for j := 0; j <= n-stampWidth; j++ {
			sum := prefixSum[i+stampHeight][j+stampWidth] - prefixSum[i][j+stampWidth] - prefixSum[i+stampHeight][j] + prefixSum[i][j]
			if sum == 0 {
				diff[i][j]++
				if i+stampHeight < m {
					diff[i+stampHeight][j]--
				}
				if j+stampWidth < n {
					diff[i][j+stampWidth]--
				}
				if i+stampHeight < m && j+stampWidth < n {
					diff[i+stampHeight][j+stampWidth]++
				}
			}
		}
	}

	sum := make([][]int, m+1)
	for i := 0; i <= m; i++ {
		sum[i] = make([]int, n+1)
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			sum[i][j] = sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1] + diff[i-1][j-1]
		}
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 0 && sum[i+1][j+1] == 0 {
				return false
			}
		}
	}

	return true
}
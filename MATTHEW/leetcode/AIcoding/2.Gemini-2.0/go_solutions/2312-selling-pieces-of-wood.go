import "fmt"

func sellingWood(m int, n int, prices [][]int) int64 {
	dp := make([][]int64, m+1)
	for i := range dp {
		dp[i] = make([]int64, n+1)
	}

	priceMap := make(map[int]map[int]int)
	for _, p := range prices {
		r, c, price := p[0], p[1], p[2]
		if _, ok := priceMap[r]; !ok {
			priceMap[r] = make(map[int]int)
		}
		priceMap[r][c] = price
	}

	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			if _, ok := priceMap[i]; ok {
				if _, ok2 := priceMap[i][j]; ok2 {
					dp[i][j] = int64(priceMap[i][j])
				}
			}

			for k := 1; k <= i/2; k++ {
				dp[i][j] = max(dp[i][j], dp[k][j]+dp[i-k][j])
			}

			for k := 1; k <= j/2; k++ {
				dp[i][j] = max(dp[i][j], dp[i][k]+dp[i][j-k])
			}
		}
	}

	return dp[m][n]
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
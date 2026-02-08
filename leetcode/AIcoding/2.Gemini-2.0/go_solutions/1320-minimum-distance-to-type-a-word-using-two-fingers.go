func minimumDistance(word string) int {
	n := len(word)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, 27*27)
		for j := range dp[i] {
			dp[i][j] = 1<<30
		}
	}

	dp[0][26*27+26] = 0

	for i := 0; i < n; i++ {
		c := int(word[i] - 'A')
		for l1 := 0; l1 < 27; l1++ {
			for l2 := 0; l2 < 27; l2++ {
				idx := l1*27 + l2
				if dp[i][idx] == 1<<30 {
					continue
				}

				dist1 := 0
				if l1 != 26 {
					x1, y1 := l1/6, l1%6
					x2, y2 := c/6, c%6
					dist1 = abs(x1-x2) + abs(y1-y2)
				}

				dist2 := 0
				if l2 != 26 {
					x1, y1 := l2/6, l2%6
					x2, y2 := c/6, c%6
					dist2 = abs(x1-x2) + abs(y1-y2)
				}

				dp[i+1][c*27+l2] = min(dp[i+1][c*27+l2], dp[i][idx]+dist1)
				dp[i+1][l1*27+c] = min(dp[i+1][l1*27+c], dp[i][idx]+dist2)

			}
		}
	}

	ans := 1 << 30
	for l1 := 0; l1 < 27; l1++ {
		for l2 := 0; l2 < 27; l2++ {
			idx := l1*27 + l2
			ans = min(ans, dp[n][idx])
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

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
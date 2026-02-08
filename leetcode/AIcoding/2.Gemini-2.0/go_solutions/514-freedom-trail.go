import "math"

func findRotateSteps(ring string, key string) int {
	n, m := len(ring), len(key)
	pos := make([][]int, 26)
	for i := 0; i < n; i++ {
		pos[ring[i]-'a'] = append(pos[ring[i]-'a'], i)
	}

	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = 1000000
		}
	}

	for _, p := range pos[key[0]-'a'] {
		dp[0][p] = int(math.Min(float64(p), float64(n-p))) + 1
	}

	for i := 1; i < m; i++ {
		for _, j := range pos[key[i]-'a'] {
			for _, k := range pos[key[i-1]-'a'] {
				diff := int(math.Abs(float64(j - k)))
				step := int(math.Min(float64(diff), float64(n-diff)))
				dp[i][j] = int(math.Min(float64(dp[i][j]), float64(dp[i-1][k]+step+1)))
			}
		}
	}

	ans := 1000000
	for _, p := range pos[key[m-1]-'a'] {
		ans = int(math.Min(float64(ans), float64(dp[m-1][p])))
	}

	return ans
}
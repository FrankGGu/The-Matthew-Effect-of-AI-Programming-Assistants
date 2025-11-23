func canCross(stones []int) bool {
	n := len(stones)
	if n <= 1 {
		return true
	}
	if stones[1] != 1 {
		return false
	}

	dp := make(map[int]map[int]bool)
	for i := 0; i < n; i++ {
		dp[stones[i]] = make(map[int]bool)
	}

	dp[1][1] = true

	for i := 1; i < n; i++ {
		stone := stones[i]
		for k := range dp[stone] {
			nextStones := []int{stone + k - 1, stone + k, stone + k + 1}
			for _, nextStone := range nextStones {
				if _, ok := dp[nextStone]; ok {
					nextK := nextStone - stone
					if nextK > 0 {
						dp[nextStone][nextK] = true
					}
				}
			}
		}
	}

	for _ = range dp[stones[n-1]] {
		return true
	}

	return false
}
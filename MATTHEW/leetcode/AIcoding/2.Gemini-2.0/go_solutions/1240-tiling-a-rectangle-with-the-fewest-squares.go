func tilingRectangle(n int, m int) int {
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, m+1)
		for j := range dp[i] {
			dp[i][j] = 200
		}
	}

	var solve func(int, int) int
	solve = func(a, b int) int {
		if a == b {
			return 1
		}
		if a == 0 || b == 0 {
			return 0
		}
		if dp[a][b] != 200 {
			return dp[a][b]
		}

		ans := 200

		// Cut horizontally
		for i := 1; i < a; i++ {
			ans = min(ans, solve(i, b)+solve(a-i, b))
		}

		// Cut vertically
		for j := 1; j < b; j++ {
			ans = min(ans, solve(a, j)+solve(a, b-j))
		}

		dp[a][b] = ans
		return ans
	}

	var fillBoard func(int, int, []bool) int
	fillBoard = func(a, b int, filled []bool) int {
		if allFilled(filled) {
			return 0
		}

		x, y := -1, -1
		for i := 0; i < a; i++ {
			for j := 0; j < b; j++ {
				if !filled[i*b+j] {
					x, y = i, j
					break
				}
			}
			if x != -1 {
				break
			}
		}

		ans := 200

		for k := 1; x+k <= a && y+k <= b; k++ {
			ok := true
			for i := x; i < x+k; i++ {
				for j := y; j < y+k; j++ {
					if filled[i*b+j] {
						ok = false
						break
					}
				}
				if !ok {
					break
				}
			}
			if !ok {
				break
			}

			newFilled := make([]bool, len(filled))
			copy(newFilled, filled)
			for i := x; i < x+k; i++ {
				for j := y; j < y+k; j++ {
					newFilled[i*b+j] = true
				}
			}

			ans = min(ans, 1+fillBoard(a, b, newFilled))
		}
		return ans
	}

	filled := make([]bool, n*m)
	return fillBoard(n, m, filled)
}

func allFilled(filled []bool) bool {
	for _, f := range filled {
		if !f {
			return false
		}
	}
	return true
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
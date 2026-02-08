func canIWin(maxChoosableInteger int, desiredTotal int) bool {
	if desiredTotal <= 0 {
		return true
	}

	sumAll := maxChoosableInteger * (maxChoosableInteger + 1) / 2
	if sumAll < desiredTotal {
		return false
	}

	memo := make(map[int]bool)

	var dfs func(mask int, currentTotal int) bool
	dfs = func(mask int, currentTotal int) bool {
		if val, ok := memo[mask]; ok {
			return val
		}

		for i := 1; i <= maxChoosableInteger; i++ {
			if (mask>>(i-1))&1 == 0 {
				if currentTotal+i >= desiredTotal {
					memo[mask] = true
					return true
				}

				if !dfs(mask|(1<<(i-1)), currentTotal+i) {
					memo[mask] = true
					return true
				}
			}
		}

		memo[mask] = false
		return false
	}

	return dfs(0, 0)
}
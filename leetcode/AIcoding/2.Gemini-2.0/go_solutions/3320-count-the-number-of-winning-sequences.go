import "sort"

func countTheNumberofWinningSequences(n int, k int, time []int) int {
	sort.Ints(time)
	dp := make(map[string]int)

	var solve func(idx int, last int, used []bool) int
	solve = func(idx int, last int, used []bool) int {
		key := ""
		for i := 0; i < len(used); i++ {
			if used[i] {
				key += "1"
			} else {
				key += "0"
			}
		}
		key += "_" + string(rune(last+'0'))

		if idx == n {
			return 1
		}

		if val, ok := dp[key]; ok {
			return val
		}

		ans := 0
		for i := 0; i < len(time); i++ {
			if !used[i] {
				if idx == 0 || time[i]-last > k {
					newUsed := make([]bool, len(used))
					copy(newUsed, used)
					newUsed[i] = true
					ans += solve(idx+1, time[i], newUsed)
				}
			}
		}

		dp[key] = ans
		return ans
	}

	used := make([]bool, len(time))
	return solve(0, 0, used)
}
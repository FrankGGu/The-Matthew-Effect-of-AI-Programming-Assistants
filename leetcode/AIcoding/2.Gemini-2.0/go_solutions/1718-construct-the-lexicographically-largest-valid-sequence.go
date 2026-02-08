func constructDistancedSequence(n int) []int {
	ans := make([]int, 2*n-1)
	used := make([]bool, n+1)

	var solve func(int) bool
	solve = func(idx int) bool {
		if idx == len(ans) {
			return true
		}
		if ans[idx] != 0 {
			return solve(idx + 1)
		}

		for num := n; num >= 1; num-- {
			if !used[num] {
				if num == 1 {
					ans[idx] = num
					used[num] = true
					if solve(idx + 1) {
						return true
					}
					used[num] = false
					ans[idx] = 0
				} else if idx+num < len(ans) && ans[idx+num] == 0 {
					ans[idx] = num
					ans[idx+num] = num
					used[num] = true
					if solve(idx + 1) {
						return true
					}
					used[num] = false
					ans[idx] = 0
					ans[idx+num] = 0
				}
			}
		}
		return false
	}

	solve(0)
	return ans
}
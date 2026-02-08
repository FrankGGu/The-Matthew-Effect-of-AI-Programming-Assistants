package main

func constructDistancedSequence(n int) []int {
	length := 2*n - 1
	ans := make([]int, length)
	used := make([]bool, n+1)

	var backtrack func(idx int) bool
	backtrack = func(idx int) bool {
		if idx == length {
			return true
		}

		if ans[idx] != 0 {
			return backtrack(idx + 1)
		}

		for v := n; v >= 1; v-- {
			if used[v] {
				continue
			}

			if v == 1 {
				ans[idx] = 1
				used[1] = true
				if backtrack(idx + 1) {
					return true
				}
				used[1] = false
				ans[idx] = 0
			} else {
				if idx+v < length && ans[idx+v] == 0 {
					ans[idx] = v
					ans[idx+v] = v
					used[v] = true
					if backtrack(idx + 1) {
						return true
					}
					used[v] = false
					ans[idx] = 0
					ans[idx+v] = 0
				}
			}
		}
		return false
	}

	backtrack(0)
	return ans
}
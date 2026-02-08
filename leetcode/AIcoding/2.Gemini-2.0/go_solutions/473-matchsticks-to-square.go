import "sort"

func makesquare(matchsticks []int) bool {
	sum := 0
	for _, m := range matchsticks {
		sum += m
	}
	if sum%4 != 0 {
		return false
	}
	target := sum / 4
	sort.Sort(sort.Reverse(sort.IntSlice(matchsticks)))
	sides := [4]int{}

	var dfs func(int) bool
	dfs = func(index int) bool {
		if index == len(matchsticks) {
			return sides[0] == target && sides[1] == target && sides[2] == target && sides[3] == target
		}
		for i := 0; i < 4; i++ {
			if sides[i]+matchsticks[index] <= target {
				sides[i] += matchsticks[index]
				if dfs(index + 1) {
					return true
				}
				sides[i] -= matchsticks[index]
			}
		}
		return false
	}

	return dfs(0)
}
import (
	"sort"
)

func maximizeTowerHeight(n int, x []int) int {
	sort.Ints(x)
	count := make(map[int]int)
	for _, val := range x {
		count[val]++
	}
	unique := make([]int, 0)
	for val := range count {
		unique = append(unique, val)
	}
	sort.Ints(unique)

	dp := make(map[int]int)
	dp[0] = 0

	for _, val := range unique {
		newDp := make(map[int]int)
		for k, v := range dp {
			newDp[k] = max(newDp[k], v)
			if k+1 <= n {
				newDp[k+1] = max(newDp[k+1], v+val)
			}
		}
		dp = newDp
	}

	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
import "fmt"

func leastOpsExpressTarget(x int, target int) int {
	dp := make([][]int, 41)
	for i := range dp {
		dp[i] = make([]int, 2)
	}

	var solve func(target int, level int)
	solve = func(target int, level int) {
		if target == 0 {
			dp[level][0] = 0
			dp[level][1] = 0
			return
		}

		if dp[level][0] != 0 || dp[level][1] != 0 {
			return
		}

		rem := target % x
		quo := target / x

		solve(quo, level+1)

		if rem == 0 {
			dp[level][0] = dp[level+1][0] + level
			dp[level][1] = dp[level+1][1] + level
		} else {
			dp[level][0] = min(rem*level+dp[level+1][0]+level, (x-rem)*level+dp[level+1][1]+level)
			dp[level][1] = min(rem*level+dp[level+1][1]+level, (x-rem)*level+dp[level+1][0]+level)
		}
	}

	solve(target, 1)
	return dp[1][0] - 1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
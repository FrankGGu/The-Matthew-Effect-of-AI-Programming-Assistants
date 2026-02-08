import (
	"fmt"
	"math"
)

func minSessions(tasks []int, sessionTime int) int {
	n := len(tasks)
	dp := make([]int, 1<<n)
	for i := 1; i < (1 << n); i++ {
		dp[i] = math.MaxInt32
	}

	for mask := 0; mask < (1 << n); mask++ {
		if dp[mask] == math.MaxInt32 {
			continue
		}
		for i := 0; i < n; i++ {
			if (mask & (1 << i)) == 0 {
				curTime := 0
				newMask := mask
				for j := 0; j < n; j++ {
					if (newMask & (1 << j)) == 0 && curTime+tasks[j] <= sessionTime {
						curTime += tasks[j]
						newMask |= (1 << j)
					}
				}
				dp[newMask] = min(dp[newMask], dp[mask]+1)

				break
			}
		}
	}

	return dp[(1<<n)-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
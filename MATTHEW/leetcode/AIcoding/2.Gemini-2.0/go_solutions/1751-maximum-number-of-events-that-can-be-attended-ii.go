import "sort"

func maxEvents(events [][]int, k int) int {
	sort.Slice(events, func(i, j int) bool {
		return events[i][0] < events[j][0]
	})

	n := len(events)
	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	for i := n - 1; i >= 0; i-- {
		for j := 1; j <= k; j++ {
			next := findNext(events, events[i][1])
			attend := events[i][2] + dp[next][j-1]
			skip := dp[i+1][j]
			dp[i][j] = max(attend, skip)
		}
	}

	return dp[0][k]
}

func findNext(events [][]int, end int) int {
	l, r := 0, len(events)
	for l < r {
		mid := (l + r) / 2
		if events[mid][0] <= end {
			l = mid + 1
		} else {
			r = mid
		}
	}
	return l
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
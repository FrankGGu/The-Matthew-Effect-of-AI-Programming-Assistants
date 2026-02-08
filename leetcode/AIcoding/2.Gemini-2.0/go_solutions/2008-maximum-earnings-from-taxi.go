import "sort"

func maxTaxiEarnings(n int, rides [][]int) int64 {
	sort.Slice(rides, func(i, j int) bool {
		return rides[i][1] < rides[j][1]
	})

	dp := make([]int64, len(rides)+1)

	for i := 1; i <= len(rides); i++ {
		dp[i] = dp[i-1]
		start, end, tip := rides[i-1][0], rides[i-1][1], rides[i-1][2]
		l, r := 0, i-1
		idx := 0
		for l <= r {
			mid := (l + r) / 2
			if rides[mid][1] <= start {
				idx = mid + 1
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
		dp[i] = max(dp[i], dp[idx]+int64(end-start+tip))
	}

	return dp[len(rides)]
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
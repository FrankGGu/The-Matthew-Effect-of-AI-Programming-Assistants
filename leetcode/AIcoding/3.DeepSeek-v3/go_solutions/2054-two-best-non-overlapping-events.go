import (
	"sort"
)

func maxTwoEvents(events [][]int) int {
	sort.Slice(events, func(i, j int) bool {
		return events[i][1] < events[j][1]
	})

	n := len(events)
	dp := make([]int, n)
	dp[0] = events[0][2]
	for i := 1; i < n; i++ {
		dp[i] = max(dp[i-1], events[i][2])
	}

	maxVal := 0
	for i := 1; i < n; i++ {
		low, high := 0, i-1
		best := -1
		for low <= high {
			mid := (low + high) / 2
			if events[mid][1] < events[i][0] {
				best = mid
				low = mid + 1
			} else {
				high = mid - 1
			}
		}
		current := events[i][2]
		if best != -1 {
			current += dp[best]
		}
		if current > maxVal {
			maxVal = current
		}
	}

	singleMax := 0
	for _, event := range events {
		if event[2] > singleMax {
			singleMax = event[2]
		}
	}

	return max(maxVal, singleMax)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
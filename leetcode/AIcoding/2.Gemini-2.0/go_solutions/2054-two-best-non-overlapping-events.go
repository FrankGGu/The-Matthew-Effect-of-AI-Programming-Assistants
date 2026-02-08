import "sort"

func maxTwoEvents(events [][]int) int {
	sort.Slice(events, func(i, j int) bool {
		return events[i][1] < events[j][1]
	})

	n := len(events)
	maxVal := 0
	suffixMax := make([]int, n)
	suffixMax[n-1] = events[n-1][2]
	for i := n - 2; i >= 0; i-- {
		suffixMax[i] = max(suffixMax[i+1], events[i][2])
	}

	for i := 0; i < n-1; i++ {
		l, r := i+1, n-1
		idx := -1
		for l <= r {
			mid := (l + r) / 2
			if events[mid][0] > events[i][1] {
				idx = mid
				r = mid - 1
			} else {
				l = mid + 1
			}
		}

		if idx != -1 {
			maxVal = max(maxVal, events[i][2]+suffixMax[idx])
		} else {
			maxVal = max(maxVal, events[i][2])
		}

	}

	maxVal = max(maxVal, suffixMax[0])
	return maxVal
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
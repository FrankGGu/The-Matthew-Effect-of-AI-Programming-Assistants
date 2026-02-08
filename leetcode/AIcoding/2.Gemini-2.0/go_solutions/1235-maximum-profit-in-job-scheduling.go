import "sort"

func jobScheduling(startTime []int, endTime []int, profit []int) int {
	jobs := make([][]int, len(startTime))
	for i := 0; i < len(startTime); i++ {
		jobs[i] = []int{startTime[i], endTime[i], profit[i]}
	}

	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i][1] < jobs[j][1]
	})

	dp := make(map[int]int)
	dp[0] = 0

	for _, job := range jobs {
		start, end, p := job[0], job[1], job[2]

		prevEnd := 0
		l, r := 0, len(jobs)-1
		for l <= r {
			mid := (l + r) / 2
			if jobs[mid][1] <= start {
				prevEnd = jobs[mid][1]
				l = mid + 1
			} else {
				r = mid - 1
			}
		}

		maxProfit := 0
		for k, v := range dp {
			if k <= start {
				maxProfit = max(maxProfit, v)
			}
		}

		currentProfit := 0
		if prevEnd != 0 {
			if val, ok := dp[prevEnd]; ok {
				currentProfit = val
			}
		}

		currentProfit = max(currentProfit, maxProfit)

		if _, ok := dp[end]; !ok {
			dp[end] = currentProfit + p
		} else {
			dp[end] = max(dp[end], currentProfit + p)
		}

		max_val := 0
		for _, v := range dp {
			max_val = max(max_val, v)
		}

		dp[end] = max(dp[end], max_val)
	}

	maxProfit := 0
	for _, v := range dp {
		maxProfit = max(maxProfit, v)
	}

	return maxProfit
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
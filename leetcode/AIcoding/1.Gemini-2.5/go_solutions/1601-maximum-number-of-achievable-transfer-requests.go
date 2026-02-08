func maximumRequests(n int, requests [][]int) int {
	maxRequests := 0
	numRequests := len(requests)

	for i := 0; i < (1 << numRequests); i++ {
		balance := make([]int, n)
		currentRequestsCount := 0

		for j := 0; j < numRequests; j++ {
			if (i >> j) & 1 == 1 {
				currentRequestsCount++
				from := requests[j][0]
				to := requests[j][1]
				balance[from]--
				balance[to]++
			}
		}

		isAchievable := true
		for k := 0; k < n; k++ {
			if balance[k] != 0 {
				isAchievable = false
				break
			}
		}

		if isAchievable {
			if currentRequestsCount > maxRequests {
				maxRequests = currentRequestsCount
			}
		}
	}

	return maxRequests
}
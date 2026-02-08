func findingUsersActiveMinutes(logs [][]int, k int) []int {
	userActivity := make(map[int]map[int]struct{})

	for _, log := range logs {
		userID := log[0]
		minute := log[1]

		if _, exists := userActivity[userID]; !exists {
			userActivity[userID] = make(map[int]struct{})
		}
		userActivity[userID][minute] = struct{}{}
	}

	uamCounts := make([]int, k+1) // uamCounts[j] will store the number of users with UAM = j

	for _, minutesSet := range userActivity {
		uam := len(minutesSet)
		if uam >= 1 && uam <= k {
			uamCounts[uam]++
		}
	}

	result := make([]int, k)
	for i := 0; i < k; i++ {
		result[i] = uamCounts[i+1]
	}

	return result
}
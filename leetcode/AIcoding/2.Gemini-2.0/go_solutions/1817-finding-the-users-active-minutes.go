func findingUsersActiveMinutes(logs [][]int, k int) []int {
	userActiveMinutes := make(map[int]map[int]bool)
	for _, log := range logs {
		userID := log[0]
		minute := log[1]
		if _, ok := userActiveMinutes[userID]; !ok {
			userActiveMinutes[userID] = make(map[int]bool)
		}
		userActiveMinutes[userID][minute] = true
	}

	result := make([]int, k)
	for _, minutes := range userActiveMinutes {
		activeMinutes := len(minutes)
		if activeMinutes <= k {
			result[activeMinutes-1]++
		}
	}

	return result
}
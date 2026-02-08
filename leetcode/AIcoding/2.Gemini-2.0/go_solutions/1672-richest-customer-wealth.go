func maximumWealth(accounts [][]int) int {
	maxWealth := 0
	for _, account := range accounts {
		wealth := 0
		for _, money := range account {
			wealth += money
		}
		if wealth > maxWealth {
			maxWealth = wealth
		}
	}
	return maxWealth
}
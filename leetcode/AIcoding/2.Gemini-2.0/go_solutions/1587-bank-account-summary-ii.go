func accountSummary(transactions [][]int) [][]int {
	balance := make(map[int]int)
	for _, t := range transactions {
		accountID := t[0]
		amount := t[1]
		balance[accountID] += amount
	}

	var result [][]int
	for accountID, amount := range balance {
		if amount > 10000 {
			result = append(result, []int{accountID, amount})
		}
	}

	return result
}
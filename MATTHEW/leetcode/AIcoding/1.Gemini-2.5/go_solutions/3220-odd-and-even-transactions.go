func oddEvenTransactions(transactions [][]int) []int {
	evenSum := 0
	oddSum := 0

	for _, transaction := range transactions {
		amount := transaction[1]
		if amount%2 == 0 {
			evenSum += amount
		} else {
			oddSum += amount
		}
	}

	return []int{evenSum, oddSum}
}
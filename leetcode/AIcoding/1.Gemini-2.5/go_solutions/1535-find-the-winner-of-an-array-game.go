func getWinner(arr []int, k int) int {
	currentWinner := arr[0]
	consecutiveWins := 0

	for i := 1; i < len(arr); i++ {
		challenger := arr[i]
		if currentWinner > challenger {
			consecutiveWins++
		} else {
			currentWinner = challenger
			consecutiveWins = 1
		}

		if consecutiveWins == k {
			return currentWinner
		}
	}

	return currentWinner
}
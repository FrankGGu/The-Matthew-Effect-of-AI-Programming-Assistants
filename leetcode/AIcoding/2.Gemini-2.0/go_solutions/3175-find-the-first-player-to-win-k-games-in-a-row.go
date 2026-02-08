func getWinner(arr []int, k int) int {
	if k >= len(arr)-1 {
		maxVal := arr[0]
		for i := 1; i < len(arr); i++ {
			if arr[i] > maxVal {
				maxVal = arr[i]
			}
		}
		return maxVal
	}

	winner := arr[0]
	winCount := 0
	for i := 1; i < len(arr); i++ {
		if winner > arr[i] {
			winCount++
		} else {
			winner = arr[i]
			winCount = 1
		}
		if winCount == k {
			return winner
		}
	}
	return winner
}
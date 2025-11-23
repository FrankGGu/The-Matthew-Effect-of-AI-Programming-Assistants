func timeNeededToBuy(tickets []int, k int) int {
	time := 0
	for tickets[k] > 0 {
		for i := 0; i < len(tickets); i++ {
			if tickets[i] > 0 {
				tickets[i]--
				time++
				if tickets[k] == 0 {
					return time
				}
			}
		}
	}
	return time
}
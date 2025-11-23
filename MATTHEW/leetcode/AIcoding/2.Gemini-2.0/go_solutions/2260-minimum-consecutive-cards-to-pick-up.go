func minimumCardPickup(cards []int) int {
	ans := -1
	last := make(map[int]int)
	for i, card := range cards {
		if j, ok := last[card]; ok {
			if ans == -1 || i-j+1 < ans {
				ans = i - j + 1
			}
		}
		last[card] = i
	}
	return ans
}
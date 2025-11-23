func numTimesAllBlue(flips []int) int {
	maxFlip := 0
	count := 0
	for i, flip := range flips {
		if flip > maxFlip {
			maxFlip = flip
		}
		if maxFlip == i+1 {
			count++
		}
	}
	return count
}
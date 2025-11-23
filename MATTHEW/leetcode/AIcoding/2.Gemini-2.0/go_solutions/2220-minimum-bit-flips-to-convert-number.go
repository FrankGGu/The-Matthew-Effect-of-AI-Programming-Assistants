func minBitFlips(start int, goal int) int {
	xorResult := start ^ goal
	count := 0
	for xorResult > 0 {
		count += xorResult & 1
		xorResult >>= 1
	}
	return count
}
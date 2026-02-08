func minimumSwaps(balls string) int {
	count := 0
	swaps := 0
	for i := 0; i < len(balls); i++ {
		if balls[i] == '1' {
			swaps += i - count
			count++
		}
	}
	return swaps
}
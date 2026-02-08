func numJewelsInStones(J string, S string) int {
	jewels := make(map[rune]bool)
	for _, r := range J {
		jewels[r] = true
	}

	count := 0
	for _, r := range S {
		if jewels[r] {
			count++
		}
	}

	return count
}
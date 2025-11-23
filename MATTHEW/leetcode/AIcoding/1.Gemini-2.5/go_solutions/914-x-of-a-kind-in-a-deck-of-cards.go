func hasGroupsSizeX(deck []int) bool {
	if len(deck) < 2 {
		return false
	}

	counts := make(map[int]int)
	for _, card := range deck {
		counts[card]++
	}

	firstCount := -1
	for _, count := range counts {
		if firstCount == -1 {
			firstCount = count
		} else {
			firstCount = gcd(firstCount, count)
		}
	}

	return firstCount >= 2
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}
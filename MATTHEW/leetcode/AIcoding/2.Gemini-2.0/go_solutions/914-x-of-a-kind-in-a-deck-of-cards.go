func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func hasGroupsSizeX(deck []int) bool {
	if len(deck) < 2 {
		return false
	}

	counts := make(map[int]int)
	for _, card := range deck {
		counts[card]++
	}

	g := 0
	for _, count := range counts {
		g = gcd(g, count)
	}

	return g >= 2
}
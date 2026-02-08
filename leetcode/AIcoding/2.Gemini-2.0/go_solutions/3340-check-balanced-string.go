func checkBalancedString(s string) bool {
	count := make(map[rune]int)
	for _, r := range s {
		count[r]++
	}

	avg := len(s) / 4
	over := 0
	for _, c := range count {
		if c > avg {
			over += c - avg
		}
	}

	return over <= len(s)/4
}
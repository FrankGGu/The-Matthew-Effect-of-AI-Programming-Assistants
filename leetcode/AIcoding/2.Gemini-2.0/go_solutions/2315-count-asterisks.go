func countAsterisks(s string) int {
	count := 0
	inPair := false
	for _, char := range s {
		if char == '*' && !inPair {
			count++
		} else if char == '|' {
			inPair = !inPair
		}
	}
	return count
}
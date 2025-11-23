func minFlips(target string) int {
	flips := 0
	current := '0'
	for _, c := range target {
		if c != current {
			flips++
			current = c
		}
	}
	return flips
}
func minimumMoves(s string) int {
	n := len(s)
	count := 0
	i := 0
	for i < n {
		if s[i] == 'X' {
			count++
			i += 3
		} else {
			i++
		}
	}
	return count
}
func countKeyChanges(s string) int {
	count := 0
	prev := ' '
	for _, char := range s {
		c := char
		if 'A' <= c && c <= 'Z' {
			c = c - 'A' + 'a'
		}
		if prev == ' ' {
			prev = c
		} else if c != prev {
			count++
			prev = c
		}
	}
	return count
}
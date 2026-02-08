func minimumBuckets(street string) int {
	n := len(street)
	s := []rune(street) // Convert string to a slice of runes for in-place modification

	buckets := 0

	for i := 0; i < n; i++ {
		if s[i] == 'H' {
			// Check
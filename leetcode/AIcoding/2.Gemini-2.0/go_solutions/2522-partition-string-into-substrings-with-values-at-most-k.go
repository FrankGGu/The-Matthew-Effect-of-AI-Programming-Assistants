func partitionString(s string, k int) int {
	count := 1
	curr := 0
	seen := make(map[rune]bool)
	for _, c := range s {
		val := int(c - 'a' + 1)
		if val > k {
			return -1
		}
		if seen[c] {
			count++
			curr = val
			seen = make(map[rune]bool)
			seen[c] = true
		} else {
			if curr+val > k {
				count++
				curr = val
				seen = make(map[rune]bool)
				seen[c] = true
			} else {
				curr += val
				seen[c] = true
			}
		}
	}
	return count
}
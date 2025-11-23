func hasAllCodes(s string, k int) bool {
	if k > len(s) {
		return false
	}
	seen := make(map[string]bool)
	for i := 0; i <= len(s)-k; i++ {
		seen[s[i:i+k]] = true
	}
	return len(seen) == 1<<k
}
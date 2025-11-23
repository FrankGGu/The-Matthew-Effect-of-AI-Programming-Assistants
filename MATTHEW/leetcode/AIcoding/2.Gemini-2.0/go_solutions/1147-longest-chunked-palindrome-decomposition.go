func longestDecomposition(text string) int {
	n := len(text)
	if n == 0 {
		return 0
	}
	for i := 0; i < n/2; i++ {
		if text[:i+1] == text[n-i-1:] {
			return 2 + longestDecomposition(text[i+1:n-i-1])
		}
	}
	return 1
}
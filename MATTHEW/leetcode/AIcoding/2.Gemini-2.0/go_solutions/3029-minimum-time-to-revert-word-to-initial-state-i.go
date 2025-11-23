func minimumTimeToInitialState(word string, k int) int {
	n := len(word)
	count := 1
	for i := k; i < n; i += k {
		if word[i:] == word[:n-i] {
			return count
		}
		count++
	}
	return count
}
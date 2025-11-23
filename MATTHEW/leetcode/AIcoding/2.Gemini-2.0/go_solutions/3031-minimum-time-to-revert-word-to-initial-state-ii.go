func minimumTimeToInitialState(word string, k int) int {
	n := len(word)
	count := 1
	for i := k; i < n; i += k {
		if word[:n-i] == word[i:] {
			break
		}
		count++
	}
	return count
}
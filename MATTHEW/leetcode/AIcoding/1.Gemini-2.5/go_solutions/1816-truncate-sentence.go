func truncateSentence(s string, k int) string {
	words := strings.Fields(s)
	if k >= len(words) {
		return s
	}
	return strings.Join(words[:k], " ")
}
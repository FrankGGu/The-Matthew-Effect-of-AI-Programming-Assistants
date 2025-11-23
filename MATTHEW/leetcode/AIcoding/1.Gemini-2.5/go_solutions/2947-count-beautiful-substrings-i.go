func isVowel(char byte) bool {
	return char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u'
}

func beautifulSubstrings(s string, k int) int {
	n := len(s)
	count := 0

	for i
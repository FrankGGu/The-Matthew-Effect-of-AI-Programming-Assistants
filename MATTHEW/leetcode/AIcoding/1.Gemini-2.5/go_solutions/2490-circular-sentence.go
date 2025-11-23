import "strings"

func isCircularSentence(sentence string) bool {
	words := strings.Fields(sentence)
	n := len(words)

	// Check condition 1: The last character of each word is equal to the first character of the next word.
	for i := 0; i < n-1; i++ {
		if words[i][len(words[i])-1] != words[i+1][0] {
			return false
		}
	}

	// Check condition 2: The last character of the last word is equal to the first character of the first word.
	// This also correctly handles the case of a single-word sentence.
	if words[n-1][len(words[n-1])-1] != words[0][0] {
		return false
	}

	return true
}
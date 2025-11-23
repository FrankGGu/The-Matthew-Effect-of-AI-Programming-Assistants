func findLongestWord(s string, dictionary []string) string {
	longestWord := ""

	for _, d := range dictionary {
		if isSubsequence(s, d) {
			if len(d) > len(longestWord) {
				longestWord = d
			} else if len(d) == len(longestWord) {
				// If lengths are equal, choose the lexicographically smallest one
				if d < longestWord {
					longestWord = d
				}
			}
		}
	}

	return longestWord
}

func isSubsequence(s, t string) bool {
	i, j := 0, 0 // Pointers for string s and string t
	for i < len(s) && j < len(t) {
		if s[i] == t[j] {
			j++ // Match found, advance pointer for t
		}
		i++ // Always advance pointer for s
	}
	// If j reached the end of t, it means all characters of t were found in s in order.
	return j == len(t)
}
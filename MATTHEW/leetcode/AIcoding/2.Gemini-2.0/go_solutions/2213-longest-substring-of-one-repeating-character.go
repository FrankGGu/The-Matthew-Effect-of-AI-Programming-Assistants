func longestRepeating(s string, queryCharacters []byte, queryIndices []int) []int {
	n := len(s)
	lengths := make([]int, len(queryCharacters))

	for i := 0; i < len(queryCharacters); i++ {
		sBytes := []byte(s)
		sBytes[queryIndices[i]] = queryCharacters[i]
		s = string(sBytes)

		maxLen := 0
		currLen := 0
		for j := 0; j < n; j++ {
			if j > 0 && s[j] == s[j-1] {
				currLen++
			} else {
				currLen = 1
			}
			if currLen > maxLen {
				maxLen = currLen
			}
		}

		lengths[i] = maxLen
	}

	return lengths
}
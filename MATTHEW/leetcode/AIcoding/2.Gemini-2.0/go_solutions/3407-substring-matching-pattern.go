func findAndReplacePattern(words []string, pattern string) []string {
	res := []string{}
	patternMap := make(map[byte]byte)
	wordMap := make(map[byte]byte)

	for _, word := range words {
		if len(word) != len(pattern) {
			continue
		}

		patternMap = make(map[byte]byte)
		wordMap = make(map[byte]byte)
		match := true

		for i := 0; i < len(word); i++ {
			pChar := pattern[i]
			wChar := word[i]

			if _, ok := patternMap[pChar]; !ok {
				if _, ok := wordMap[wChar]; !ok {
					patternMap[pChar] = wChar
					wordMap[wChar] = pChar
				} else {
					match = false
					break
				}
			} else {
				if patternMap[pChar] != wChar {
					match = false
					break
				}
			}
		}

		if match {
			res = append(res, word)
		}
	}

	return res
}
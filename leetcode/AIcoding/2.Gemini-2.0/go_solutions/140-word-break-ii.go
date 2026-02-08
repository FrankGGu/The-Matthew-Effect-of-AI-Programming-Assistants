func wordBreak(s string, wordDict []string) []string {
	wordSet := make(map[string]bool)
	for _, word := range wordDict {
		wordSet[word] = true
	}

	memo := make(map[string][]string)

	var breakWord func(string) []string
	breakWord = func(s string) []string {
		if res, ok := memo[s]; ok {
			return res
		}

		if len(s) == 0 {
			return []string{""}
		}

		result := []string{}
		for i := 1; i <= len(s); i++ {
			word := s[:i]
			if wordSet[word] {
				subResults := breakWord(s[i:])
				for _, subResult := range subResults {
					if subResult == "" {
						result = append(result, word)
					} else {
						result = append(result, word+" "+subResult)
					}
				}
			}
		}

		memo[s] = result
		return result
	}

	return breakWord(s)
}
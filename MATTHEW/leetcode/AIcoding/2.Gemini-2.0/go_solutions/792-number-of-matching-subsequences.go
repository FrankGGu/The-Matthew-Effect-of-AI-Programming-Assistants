func numMatchingSubseq(s string, words []string) int {
	count := 0
	heads := make([][]int, 26)
	for i, word := range words {
		heads[word[0]-'a'] = append(heads[word[0]-'a'], i)
	}

	for i := 0; i < len(s); i++ {
		idx := s[i] - 'a'
		head := heads[idx]
		heads[idx] = []int{}
		for _, j := range head {
			words[j] = words[j][1:]
			if len(words[j]) == 0 {
				count++
			} else {
				heads[words[j][0]-'a'] = append(heads[words[j][0]-'a'], j)
			}
		}
	}
	return count
}
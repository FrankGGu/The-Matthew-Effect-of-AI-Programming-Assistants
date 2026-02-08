func replaceWords(dictionary []string, sentence string) string {
	root := make(map[rune]interface{})
	for _, word := range dictionary {
		node := root
		for _, c := range word {
			if _, ok := node[c]; !ok {
				node[c] = make(map[rune]interface{})
			}
			node = node[c].(map[rune]interface{})
		}
		node['#'] = true
	}

	words := strings.Split(sentence, " ")
	for i, word := range words {
		node := root
		prefix := ""
		found := false
		for _, c := range word {
			if _, ok := node[c]; ok {
				prefix += string(c)
				node = node[c].(map[rune]interface{})
				if _, ok := node['#']; ok {
					words[i] = prefix
					found = true
					break
				}
			} else {
				break
			}
		}
		if found {
			continue
		}
	}

	return strings.Join(words, " ")
}
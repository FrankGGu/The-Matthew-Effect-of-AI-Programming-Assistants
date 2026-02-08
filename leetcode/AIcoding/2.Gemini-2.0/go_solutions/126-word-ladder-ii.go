func findLadders(beginWord string, endWord string, wordList []string) [][]string {
	wordSet := make(map[string]bool)
	for _, word := range wordList {
		wordSet[word] = true
	}
	if !wordSet[endWord] {
		return [][]string{}
	}

	queue := [][]string{{beginWord}}
	visited := map[string]bool{beginWord: true}
	result := [][]string{}
	found := false

	for len(queue) > 0 && !found {
		levelVisited := make(map[string]bool)
		levelSize := len(queue)

		for i := 0; i < levelSize; i++ {
			path := queue[0]
			queue = queue[1:]
			lastWord := path[len(path)-1]

			if lastWord == endWord {
				result = append(result, path)
				found = true
				continue
			}

			for j := 0; j < len(lastWord); j++ {
				for char := 'a'; char <= 'z'; char++ {
					nextWord := lastWord[:j] + string(char) + lastWord[j+1:]

					if wordSet[nextWord] {
						if !visited[nextWord] {
							newPath := append([]string{}, path...)
							newPath = append(newPath, nextWord)
							queue = append(queue, newPath)
							levelVisited[nextWord] = true
						}
					}
				}
			}
		}

		for word := range levelVisited {
			visited[word] = true
		}
	}

	finalResult := [][]string{}
	minLen := -1

	for _, path := range result {
		if minLen == -1 || len(path) < minLen {
			minLen = len(path)
			finalResult = [][]string{path}
		} else if len(path) == minLen {
			finalResult = append(finalResult, path)
		}
	}

	return finalResult
}
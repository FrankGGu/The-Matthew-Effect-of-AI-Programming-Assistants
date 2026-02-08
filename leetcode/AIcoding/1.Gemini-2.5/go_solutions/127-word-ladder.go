package main

import "container/list"

func ladderLength(beginWord string, endWord string, wordList []string) int {
	wordSet := make(map[string]bool)
	for _, word := range wordList {
		wordSet[word] = true
	}

	if !wordSet[endWord] {
		return 0
	}

	queue := list.New()
	queue.PushBack([]interface{}{beginWord, 1})

	visited := make(map[string]bool)
	visited[beginWord] = true

	wordLen := len(beginWord)

	for queue.Len() > 0 {
		element := queue.Remove(queue.Front()).([]interface{})
		currentWord := element[0].(string)
		level := element[1].(int)

		if currentWord == endWord {
			return level
		}

		currentWordBytes := []byte(currentWord)

		for i := 0; i < wordLen; i++ {
			originalChar := currentWordBytes[i]
			for charCode := 'a'; charCode <= 'z'; charCode++ {
				currentWordBytes[i] = byte(charCode)
				nextWord := string(currentWordBytes)

				if wordSet[nextWord] && !visited[nextWord] {
					visited[nextWord] = true
					queue.PushBack([]interface{}{nextWord, level + 1})
				}
			}
			currentWordBytes[i] = originalChar
		}
	}

	return 0
}
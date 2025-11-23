package main

func ladderLength(beginWord string, endWord string, wordList []string) int {
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }
    if !wordSet[endWord] {
        return 0
    }

    queue := []string{beginWord}
    visited := make(map[string]bool)
    visited[beginWord] = true

    level := 1

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]

            for j := 0; j < len(current); j++ {
                for c := 'a'; c <= 'z'; c++ {
                    nextWord := current[:j] + string(c) + current[j+1:]
                    if nextWord == endWord {
                        return level + 1
                    }
                    if wordSet[nextWord] && !visited[nextWord] {
                        visited[nextWord] = true
                        queue = append(queue, nextWord)
                    }
                }
            }
        }
        level++
    }

    return 0
}
import "strings"

func ladderLength(beginWord string, endWord string, wordList []string) int {
    wordSet := make(map[string]struct{})
    for _, word := range wordList {
        wordSet[word] = struct{}{}
    }

    if _, exists := wordSet[endWord]; !exists {
        return 0
    }

    queue := []string{beginWord}
    visited := make(map[string]bool)
    visited[beginWord] = true
    length := 1

    for len(queue) > 0 {
        length++
        nextQueue := []string{}

        for _, word := range queue {
            for i := 0; i < len(word); i++ {
                for c := 'a'; c <= 'z'; c++ {
                    newWord := word[:i] + string(c) + word[i+1:]
                    if newWord == endWord {
                        return length
                    }
                    if _, exists := wordSet[newWord]; exists && !visited[newWord] {
                        visited[newWord] = true
                        nextQueue = append(nextQueue, newWord)
                    }
                }
            }
        }
        queue = nextQueue
    }

    return 0
}
package main

func findLadder(beginWord string, endWord string, wordList []string) [][]string {
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }
    wordSet[beginWord] = true

    neighbors := make(map[string][]string)
    for _, word := range wordList {
        for i := 0; i < len(word); i++ {
            pattern := word[:i] + "*" + word[i+1:]
            neighbors[pattern] = append(neighbors[pattern], word)
        }
    }

    result := [][]string{}
    queue := [][]string{{beginWord}}
    visited := make(map[string]bool)
    visited[beginWord] = true
    found := false

    for len(queue) > 0 && !found {
        nextQueue := [][]string{}
        for _, path := range queue {
            lastWord := path[len(path)-1]
            for i := 0; i < len(lastWord); i++ {
                pattern := lastWord[:i] + "*" + lastWord[i+1:]
                for _, neighbor := range neighbors[pattern] {
                    if !visited[neighbor] {
                        newPath := append([]string{}, path...)
                        newPath = append(newPath, neighbor)
                        if neighbor == endWord {
                            result = append(result, newPath)
                            found = true
                        } else {
                            nextQueue = append(nextQueue, newPath)
                        }
                    }
                }
            }
        }
        if found {
            break
        }
        for _, path := range nextQueue {
            lastWord := path[len(path)-1]
            visited[lastWord] = true
        }
        queue = nextQueue
    }

    return result
}
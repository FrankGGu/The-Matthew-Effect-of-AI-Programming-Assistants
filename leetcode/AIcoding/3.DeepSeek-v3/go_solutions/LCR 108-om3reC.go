func ladderLength(beginWord string, endWord string, wordList []string) int {
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }
    if !wordSet[endWord] {
        return 0
    }

    queue := []string{beginWord}
    level := 1

    for len(queue) > 0 {
        levelSize := len(queue)
        for i := 0; i < levelSize; i++ {
            current := queue[0]
            queue = queue[1:]
            if current == endWord {
                return level
            }
            for j := 0; j < len(current); j++ {
                for c := 'a'; c <= 'z'; c++ {
                    newWord := current[:j] + string(c) + current[j+1:]
                    if wordSet[newWord] {
                        queue = append(queue, newWord)
                        delete(wordSet, newWord)
                    }
                }
            }
        }
        level++
    }
    return 0
}
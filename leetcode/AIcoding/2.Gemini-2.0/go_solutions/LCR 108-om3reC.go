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
    length := 1

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[0]
            queue = queue[1:]

            if curr == endWord {
                return length
            }

            for j := 0; j < len(curr); j++ {
                for k := 'a'; k <= 'z'; k++ {
                    nextWord := []rune(curr)
                    nextWord[j] = k
                    next := string(nextWord)

                    if wordSet[next] && !visited[next] {
                        queue = append(queue, next)
                        visited[next] = true
                    }
                }
            }
        }
        length++
    }

    return 0
}
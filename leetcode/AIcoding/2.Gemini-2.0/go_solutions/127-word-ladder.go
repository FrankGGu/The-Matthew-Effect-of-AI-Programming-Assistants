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
    distance := 1

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            word := queue[0]
            queue = queue[1:]

            if word == endWord {
                return distance
            }

            for j := 0; j < len(word); j++ {
                wordArr := []rune(word)
                for char := 'a'; char <= 'z'; char++ {
                    wordArr[j] = char
                    newWord := string(wordArr)

                    if wordSet[newWord] && !visited[newWord] {
                        queue = append(queue, newWord)
                        visited[newWord] = true
                    }
                }
            }
        }
        distance++
    }

    return 0
}
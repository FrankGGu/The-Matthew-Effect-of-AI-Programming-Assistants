func ladderLength(beginWord string, endWord string, wordList []string) int {
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }

    if !wordSet[endWord] {
        return 0
    }

    queue := make([]struct {
        word  string
        level int
    }, 0)

    queue = append(queue, struct {
        word  string
        level int
    }{beginWord, 1})

    visited := make(map[string]bool)
    visited[beginWord] = true

    wordLen := len(beginWord)

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]

        currWord := curr.word
        currLevel := curr.level

        if currWord == endWord {
            return currLevel
        }

        currWordBytes := []byte(currWord)

        for i := 0; i < wordLen; i++ {
            originalChar := currWordBytes[i]
            for charCode := 'a'; charCode <= 'z'; charCode++ {
                currWordBytes[i] = byte(charCode)
                nextWord := string(currWordBytes)

                if wordSet[nextWord] && !visited[nextWord] {
                    visited[nextWord] = true
                    queue = append(queue, struct {
                        word  string
                        level int
                    }{nextWord, currLevel + 1})
                }
            }
            currWordBytes[i] = originalChar // backtrack
        }
    }

    return 0
}
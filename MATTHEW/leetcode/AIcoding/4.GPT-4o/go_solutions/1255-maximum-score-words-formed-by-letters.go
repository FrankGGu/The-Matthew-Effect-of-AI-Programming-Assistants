func maxScoreWords(words []string, scores []int, letters []byte, lettersCount []int) int {
    letterScore := make(map[byte]int)
    for i, score := range scores {
        letterScore[byte(i+'a')] = score
    }

    maxScore := 0
    backtrack(words, letterScore, lettersCount, 0, 0, &maxScore)
    return maxScore
}

func backtrack(words []string, letterScore map[byte]int, lettersCount []int, index int, currentScore int, maxScore *int) {
    if index == len(words) {
        if currentScore > *maxScore {
            *maxScore = currentScore
        }
        return
    }

    word := words[index]
    wordCount := make([]int, 26)
    for i := 0; i < len(word); i++ {
        wordCount[word[i]-'a']++
    }

    canForm := true
    for i := 0; i < 26; i++ {
        if wordCount[i] > lettersCount[i] {
            canForm = false
            break
        }
    }

    if canForm {
        wordScore := 0
        for i := 0; i < len(word); i++ {
            wordScore += letterScore[word[i]]
        }
        backtrack(words, letterScore, lettersCount, index+1, currentScore+wordScore, maxScore)
    }

    backtrack(words, letterScore, lettersCount, index+1, currentScore, maxScore)
}

func CountLetters(letters []byte) []int {
    count := make([]int, 26)
    for _, letter := range letters {
        count[letter-'a']++
    }
    return count
}
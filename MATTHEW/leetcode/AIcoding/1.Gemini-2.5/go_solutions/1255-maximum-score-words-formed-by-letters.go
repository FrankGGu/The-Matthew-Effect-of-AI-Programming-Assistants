package main

func maxScoreWords(words []string, letters []byte, score []int) int {
	letterCounts := [26]int{}
	for _, l := range letters {
		letterCounts[l-'a']++
	}

	var solve func(wordIdx int, currentLetters [26]int) int
	solve = func(wordIdx int, currentLetters [26]int) int {
		if wordIdx == len(words) {
			return 0
		}

		// Option 1: Do not take the current word
		maxS := solve(wordIdx+1, currentLetters)

		// Option 2: Try to take the current word
		currentWord := words[wordIdx]
		wordScore := 0
		canForm := true

		tempLetters := currentLetters 

		for _, char := range currentWord {
			charIdx := char - 'a'
			if tempLetters[charIdx] == 0 {
				canForm = false
				break
			}
			tempLetters[charIdx]--
			wordScore += score[charIdx]
		}

		if canForm {
			maxS = max(maxS, wordScore + solve(wordIdx+1, tempLetters))
		}

		return maxS
	}

	return solve(0, letterCounts)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
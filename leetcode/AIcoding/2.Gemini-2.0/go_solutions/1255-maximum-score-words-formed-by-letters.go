func maxScoreWords(words []string, letters []byte, score []int) int {
	count := make([]int, 26)
	for _, letter := range letters {
		count[letter-'a']++
	}

	var backtrack func(int) int
	backtrack = func(index int) int {
		if index == len(words) {
			return 0
		}

		// Skip current word
		skip := backtrack(index + 1)

		// Include current word
		word := words[index]
		wordScore := 0
		tempCount := make([]int, 26)
		copy(tempCount, count)
		canInclude := true

		for _, char := range word {
			charIndex := char - 'a'
			if tempCount[charIndex] == 0 {
				canInclude = false
				break
			}
			tempCount[charIndex]--
			wordScore += score[charIndex]
		}

		include := 0
		if canInclude {
			count = tempCount
			include = wordScore + backtrack(index+1)
			count = make([]int, 26)
			for _, letter := range letters {
				count[letter-'a']++
			}
			for i := 0; i < 26; i++ {
				count[i] = tempCount[i] + (len(letters) - sum(tempCount))
			}

			tempCount = make([]int, 26)
			copy(tempCount, count)
			for _, char := range word {
				charIndex := char - 'a'
				tempCount[charIndex]--
			}
			count = tempCount
		} else {
			include = 0
		}

		count = make([]int, 26)
		for _, letter := range letters {
			count[letter-'a']++
		}

		return max(skip, include)
	}

	return backtrack(0)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func sum(arr []int) int {
	s := 0
	for _, v := range arr {
		s += v
	}
	return s
}
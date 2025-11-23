package main

import "math"

var maxLen int

type wordInfo struct {
	mask   int
	length int
}

func maxLength(arr []string) int {
	maxLen = 0

	validWords := []wordInfo{}
	for _, s := range arr {
		currentMask := 0
		isUnique := true
		for _, char := range s {
			bit := 1 << (char - 'a')
			if (currentMask & bit) != 0 {
				isUnique = false
				break
			}
			currentMask |= bit
		}
		if isUnique {
			validWords = append(validWords, wordInfo{mask: currentMask, length: len(s)})
		}
	}

	dfs(0, 0, 0, validWords)

	return maxLen
}

func dfs(index int, currentMask int, currentLength int, validWords []wordInfo) {
	if currentLength > maxLen {
		maxLen = currentLength
	}

	if index == len(validWords) {
		return
	}

	dfs(index+1, currentMask, currentLength, validWords)

	word := validWords[index]
	if (currentMask & word.mask) == 0 {
		dfs(index+1, currentMask | word.mask, currentLength + word.length, validWords)
	}
}
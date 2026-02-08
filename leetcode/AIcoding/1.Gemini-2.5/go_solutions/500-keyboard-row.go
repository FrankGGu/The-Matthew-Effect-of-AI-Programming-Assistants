package main

import (
	"strings"
	"unicode"
)

func findWords(words []string) []string {
	rowMap := make(map[rune]int)
	row1 := "qwertyuiop"
	row2 := "asdfghjkl"
	row3 := "zxcvbnm"

	for _, char := range row1 {
		rowMap[char] = 1
	}
	for _, char := range row2 {
		rowMap[char] = 2
	}
	for _, char := range row3 {
		rowMap[char] = 3
	}

	result := []string{}

	for _, word := range words {
		if len(word) == 0 {
			continue
		}

		firstChar := unicode.ToLower(rune(word[0]))
		targetRow, exists := rowMap[firstChar]
		if !exists {
			// Should not happen with standard English alphabet
			continue
		}

		onSameRow := true
		for _, char := range word {
			lowerChar := unicode.ToLower(char)
			if rowMap[lowerChar] != targetRow {
				onSameRow = false
				break
			}
		}

		if onSameRow {
			result = append(result, word)
		}
	}

	return result
}
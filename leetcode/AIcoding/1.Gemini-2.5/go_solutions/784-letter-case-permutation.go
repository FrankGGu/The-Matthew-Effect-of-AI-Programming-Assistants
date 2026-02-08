package main

import (
	"unicode"
)

func letterCasePermutation(s string) []string {
	var result []string
	sBytes := []byte(s)

	currentPermutation := make([]byte, len(sBytes))
	copy(currentPermutation, sBytes)

	var backtrack func(index int)
	backtrack = func(index int) {
		if index == len(sBytes) {
			result = append(result, string(currentPermutation))
			return
		}

		char := sBytes[index]

		if char >= '0' && char <= '9' {
			currentPermutation[index] = char
			backtrack(index + 1)
		} else {
			currentPermutation[index] = byte(unicode.ToLower(rune(char)))
			backtrack(index + 1)

			currentPermutation[index] = byte(unicode.ToUpper(rune(char)))
			backtrack(index + 1)
		}
	}

	backtrack(0)

	return result
}
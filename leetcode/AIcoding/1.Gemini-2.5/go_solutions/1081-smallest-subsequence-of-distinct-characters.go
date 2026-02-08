package main

import (
	"strings"
)

func smallestSubsequence(s string) string {
	lastOccurrences := make([]int, 26)
	for i, r := range s {
		lastOccurrences[r-'a'] = i
	}

	stack := make([]byte, 0, 26)
	inStack := make([]bool, 26)

	for i := 0; i < len(s); i++ {
		char := s[i]
		if inStack[char-'a'] {
			continue
		}

		for len(stack) > 0 && char < stack[len(stack)-1] && lastOccurrences[stack[len(stack)-1]-'a'] > i {
			poppedChar := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			inStack[poppedChar-'a'] = false
		}

		stack = append(stack, char)
		inStack[char-'a'] = true
	}

	var sb strings.Builder
	sb.Grow(len(stack))
	for _, b := range stack {
		sb.WriteByte(b)
	}

	return sb.String()
}
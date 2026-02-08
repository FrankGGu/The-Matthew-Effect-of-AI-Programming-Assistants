package main

import (
	"strings"
)

var resultSet map[string]bool
var maxLen int

func removeInvalidParentheses(s string) []string {
	resultSet = make(map[string]bool)
	maxLen = -1 // Initialize with -1 to correctly handle the case where the only valid string is ""

	leftRem := 0
	rightRem := 0

	// Calculate the minimum number of left and right parentheses that must be removed
	for _, char := range s {
		if char == '(' {
			leftRem++
		} else if char == ')' {
			if leftRem > 0 {
				leftRem--
			} else {
				rightRem++
			}
		}
	}

	var currentBuilder strings.Builder
	dfs(s, 0, 0, 0, leftRem, rightRem, &currentBuilder, &resultSet)

	var result []string
	for str := range resultSet {
		result = append(result, str)
	}
	return result
}

func dfs(s string, index int, openCount int, closeCount int, leftRem int, rightRem int, currentBuilder *strings.Builder, results *map[string]bool) {
	if index == len(s) {
		// Base case: Reached the end of the string
		// Check if all required removals have been made and parentheses are balanced
		if leftRem == 0 && rightRem == 0 && openCount == closeCount {
			currentStr := currentBuilder.String()
			// Update maxLen and results based on the length of the current valid string
			if len(currentStr) > maxLen {
				maxLen = len(currentStr)
				*results = make(map[string]bool) // Clear previous shorter results
				(*results)[currentStr] = true
			} else if len(currentStr) == maxLen {
				(*results)[currentStr] = true
			}
		}
		return
	}

	char := s[index]

	// Case 1: Current character is not a parenthesis. Always keep it.
	if char != '(' && char != ')' {
		currentBuilder.WriteByte(char)
		dfs(s, index+1, openCount, closeCount, leftRem, rightRem, currentBuilder, results)
		currentBuilder.SetLen(currentBuilder.Len() - 1) // Backtrack
		return
	}

	// Case 2: Current character is a parenthesis. We have two choices: remove or keep.

	// Choice A: Remove current character (if we still need to remove this type of parenthesis)
	if char == '(' && leftRem > 0 {
		dfs(s, index+1, openCount, closeCount, leftRem-1, rightRem, currentBuilder, results)
	}
	if char == ')' && rightRem > 0 {
		dfs(s, index+1, openCount, closeCount, leftRem, rightRem-1, currentBuilder, results)
	}

	// Choice B: Keep current character
	if char == '(' {
		currentBuilder.WriteByte(char)
		dfs(s, index+1, openCount+1, closeCount, leftRem, rightRem, currentBuilder, results)
		currentBuilder.SetLen(currentBuilder.Len() - 1) // Backtrack
	} else if char == ')' { // char == ')'
		// Only keep ')' if it can form a valid pair (i.e., there's an unmatched '(' before it)
		if closeCount < openCount {
			currentBuilder.WriteByte(char)
			dfs(s, index+1, openCount, closeCount+1, leftRem, rightRem, currentBuilder, results)
			currentBuilder.SetLen(currentBuilder.Len() - 1) // Backtrack
		}
	}
}
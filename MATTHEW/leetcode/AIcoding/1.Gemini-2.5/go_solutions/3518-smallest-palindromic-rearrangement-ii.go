package main

import (
	"sort"
	"strings"
)

func smallestPalindromicRearrangementII(s string) string {
	counts := make(map[rune]int)
	for _, char := range s {
		counts[char]++
	}

	var oddChar rune
	oddCount := 0
	for char, count := range counts {
		if count%2 != 0 {
			oddChar = char
			oddCount++
		}
	}

	if oddCount > 1 {
		return ""
	}

	var firstHalfBuilder strings.Builder

	var chars []rune
	for char := range counts {
		chars = append(chars, char)
	}
	sort.Slice(chars, func(i, j int) bool {
		return chars[i] < chars[j]
	})

	for _, char := range chars {
		for i := 0; i < counts[char]/2; i++ {
			firstHalfBuilder.WriteRune(char)
		}
	}

	firstHalf := firstHalfBuilder.String()

	var resultBuilder strings.Builder
	resultBuilder.WriteString(firstHalf)
	if oddCount == 1 {
		resultBuilder.WriteRune(oddChar)
	}

	for i := len(firstHalf) - 1; i >= 0; i-- {
		resultBuilder.WriteByte(firstHalf[i])
	}

	return resultBuilder.String()
}
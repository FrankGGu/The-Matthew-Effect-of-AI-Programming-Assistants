package main

import (
	"sort"
	"strings"
)

func smallestPalindromicRearrangement(s string) string {
	counts := make(map[rune]int)
	for _, char := range s {
		counts[char]++
	}

	oddChar := rune(0)
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
	var middleBuilder strings.Builder

	keys := make([]rune, 0, len(counts))
	for k := range counts {
		keys = append(keys, k)
	}
	sort.Slice(keys, func(i, j int) bool {
		return keys[i] < keys[j]
	})

	for _, char := range keys {
		count := counts[char]

		for i := 0; i < count/2; i++ {
			firstHalfBuilder.WriteRune(char)
		}

		if char == oddChar {
			middleBuilder.WriteRune(char)
		}
	}

	firstHalf := firstHalfBuilder.String()
	middle := middleBuilder.String()

	secondHalfRunes := []rune(firstHalf)
	for i, j := 0, len(secondHalfRunes)-1; i < j; i, j = i+1, j-1 {
		secondHalfRunes[i], secondHalfRunes[j] = secondHalfRunes[j], secondHalfRunes[i]
	}
	secondHalf := string(secondHalfRunes)

	return firstHalf + middle + secondHalf
}
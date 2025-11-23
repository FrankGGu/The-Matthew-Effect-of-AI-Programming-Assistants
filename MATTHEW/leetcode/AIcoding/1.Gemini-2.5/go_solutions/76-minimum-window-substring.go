package main

import (
	"math"
)

func minWindow(s string, t string) string {
	if len(t) == 0 {
		return ""
	}

	charCountT := make(map[byte]int)
	for i := 0; i < len(t); i++ {
		charCountT[t[i]]++
	}

	left := 0
	minLength := math.MaxInt
	startIndex := -1

	formedCount := 0 // Number of characters in window that match required characters in t (including duplicates)
	requiredCount := len(t) // Total characters needed from t

	for right := 0; right < len(s); right++ {
		charR := s[right]

		// Only process characters that are in t
		if _, ok := charCountT[charR]; ok {
			charCountT[charR]--
			if charCountT[charR] >= 0 { // This character was needed and we found one (or had an excess but it was still needed)
				formedCount++
			}
		}

		// Try to shrink the window from the left if all characters from t are found
		for formedCount == requiredCount {
			currentWindowLength := right - left + 1
			if currentWindowLength < minLength {
				minLength = currentWindowLength
				startIndex = left
			}

			charL := s[left]

			// Only process characters that are in t
			if _, ok := charCountT[charL]; ok {
				charCountT[charL]++
				if charCountT[charL] > 0 { // This character was needed, and now we are deficient again
					formedCount--
				}
			}
			left++
		}
	}

	if startIndex == -1 {
		return ""
	}
	return s[startIndex : startIndex+minLength]
}
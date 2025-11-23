package main

import "math"

func maximumLengthSubstring(s string) int {
	maxLen := 0
	left := 0
	counts := [26]int{}

	for right := 0; right < len(s); right++ {
		charR := s[right]
		counts[charR-'a']++

		for counts[charR-'a'] > 2 {
			charL := s[left]
			counts[charL-'a']--
			left++
		}

		maxLen = int(math.Max(float64(maxLen), float64(right-left+1)))
	}

	return maxLen
}
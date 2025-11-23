package main

import "math"

func lengthOfLongestSubstring(s string) int {
	charIndexMap := make(map[byte]int)
	maxLength := 0
	left := 0

	for right := 0; right < len(s); right++ {
		char := s[right]
		if prevIndex, found := charIndexMap[char]; found && prevIndex >= left {
			left = prevIndex + 1
		}
		charIndexMap[char] = right
		maxLength = int(math.Max(float64(maxLength), float64(right-left+1)))
	}

	return maxLength
}
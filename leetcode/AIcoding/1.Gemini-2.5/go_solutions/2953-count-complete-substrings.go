package main

import "math"

func countCompleteSubstrings(word string, k int) int {
	totalCount := 0
	n := len(word)
	start := 0

	for i := 0; i < n; i++ {
		// Check for segment boundary.
		// A segment ends if it's the last character or the absolute difference
		// between current and next character's ASCII value is greater than 2.
		if i == n-1 || int(math.Abs(float64(word[i])-float64(word[i+1]))) > 2 {
			segment := word[start : i+1]
			totalCount += countCompleteInSegment(segment, k)
			start = i + 1
		}
	}
	return totalCount
}

func countCompleteInSegment(segment string, k int) int {
	segmentCount := 0
	segLen := len(segment)

	// Iterate over possible number of distinct characters (m).
	// m can range from 1 up to 26 (for lowercase English letters).
	for m := 1; m <= 26; m++ {
		targetLen := m * k
		if targetLen > segLen {
			break // Cannot form a substring of this length
		}

		freq := make(map[byte]int)
		distinctChars := 0
		charsWithKFreq := 0 // Counts characters whose frequency is exactly k

		// Initialize the first window of size targetLen
		for j := 0; j < targetLen; j++ {
			char := segment[j]
			if freq[char] == 0 {
				distinctChars++
			}
			freq[char]++
			if freq[char] == k {
				charsWithKFreq++
			} else if freq[char] == k+1 {
				// If frequency just became k+1, it means it was k before,
				// so decrement charsWithKFreq.
				charsWithKFreq--
			}
		}

		// Check if the first window is a complete substring
		if distinctChars == m && charsWithKFreq == m {
			segmentCount++
		}

		// Slide the window across the segment
		for j := targetLen; j < segLen; j++ {
			// Remove the character leaving the window (segment[j - targetLen])
			oldChar := segment[j-targetLen]
			if freq[oldChar] == k {
				// If frequency was k, it will now be k-1, so decrement charsWithKFreq.
				charsWithKFreq--
			}
			freq[oldChar]--
			if freq[oldChar] == 0 {
				// If frequency became 0, it means this character is no longer in the window,
				// so decrement distinctChars.
				distinctChars--
			}

			// Add the new character entering the window (segment[j])
			newChar := segment[j]
			if freq[newChar] == 0 {
				// If frequency was 0, it means this is a new distinct character in the window.
				distinctChars++
			}
			freq[newChar]++
			if freq[newChar] == k {
				// If frequency just became k, increment charsWithKFreq.
				charsWithKFreq++
			} else if freq[newChar] == k+1 {
				// If frequency just became k+1, it means it was k before,
				// so decrement charsWithKFreq.
				charsWithKFreq--
			}

			// Check if the current window is a complete substring
			if distinctChars == m && charsWithKFreq == m {
				segmentCount++
			}
		}
	}
	return segmentCount
}
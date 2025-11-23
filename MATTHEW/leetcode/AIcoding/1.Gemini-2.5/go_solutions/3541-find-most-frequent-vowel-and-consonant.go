package main

import (
	"strings"
)

func mostFrequentVowelAndConsonant(s string) string {
	vowelCounts := [26]int{}
	consonantCounts := [26]int{}

	vowels := map[rune]bool{
		'a': true, 'e': true, 'i': true, 'o': true, 'u': true,
	}

	for _, r := range s {
		r = toLower(r)
		if r >= 'a' && r <= 'z' {
			if vowels[r] {
				vowelCounts[r-'a']++
			} else {
				consonantCounts[r-'a']++
			}
		}
	}

	maxVowelCount := -1
	mostFrequentVowel := 'a'

	vowelChars := []rune{'a', 'e', 'i', 'o', 'u'}
	for _, char := range vowelChars {
		idx := char - 'a'
		if vowelCounts[idx] > maxVowelCount {
			maxVowelCount = vowelCounts[idx]
			mostFrequentVowel = char
		} else if vowelCounts[idx] == maxVowelCount {
			// Tie-breaking: choose alphabetically smaller.
			// This is implicitly handled by iterating 'a', 'e', 'i', 'o', 'u' in order.
			// If 'a' and 'e' have the same max count, 'a' is picked first and remains.
		}
	}

	maxConsonantCount := -1
	mostFrequentConsonant := 'b' // Default to 'b' as the first consonant

	for i := 0; i < 26; i++ {
		char := rune('a' + i)
		if !vowels[char] { // Only consider actual consonants
			if consonantCounts[i] > maxConsonantCount {
				maxConsonantCount = consonantCounts[i]
				mostFrequentConsonant = char
			} else if consonantCounts[i] == maxConsonantCount {
				// Tie-breaking: choose alphabetically smaller
				if char < mostFrequentConsonant {
					mostFrequentConsonant = char
				}
			}
		}
	}

	return string(mostFrequentVowel) + string(mostFrequentConsonant)
}

func toLower(r rune) rune {
	if r >= 'A' && r <= 'Z' {
		return r + ('a' - 'A')
	}
	return r
}
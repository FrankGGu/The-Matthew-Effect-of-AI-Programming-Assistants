package main

import (
	"fmt"
	"unicode"
)

func mostFrequentVowelAndConsonant(s string) (rune, rune) {
	vowelCount := make(map[rune]int)
	consonantCount := make(map[rune]int)

	for _, ch := range s {
		if unicode.IsLetter(ch) {
			ch = unicode.ToLower(ch)
			if isVowel(ch) {
				vowelCount[ch]++
			} else {
				consonantCount[ch]++
			}
		}
	}

	var maxVowel rune
	maxVowelCount := 0
	for v, count := range vowelCount {
		if count > maxVowelCount {
			maxVowelCount = count
			maxVowel = v
		}
	}

	var maxConsonant rune
	maxConsonantCount := 0
	for c, count := range consonantCount {
		if count > maxConsonantCount {
			maxConsonantCount = count
			maxConsonant = c
		}
	}

	return maxVowel, maxConsonant
}

func isVowel(ch rune) bool {
	return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u'
}

func main() {
	s := "example input string"
	vowel, consonant := mostFrequentVowelAndConsonant(s)
	fmt.Printf("Most Frequent Vowel: %c, Most Frequent Consonant: %c\n", vowel, consonant)
}
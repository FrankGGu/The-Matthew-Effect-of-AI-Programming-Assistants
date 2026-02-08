package main

func isVowel(c rune) bool {
	return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
}

func countVowelSubstrings(word string) int {
	return atMostKDistinctVowels(word, 5) - atMostKDistinctVowels(word, 4)
}

func atMostKDistinctVowels(word string, k int) int {
	n := len(word)
	count := 0
	left := 0
	freq := make(map[rune]int)
	uniqueVowelCount := 0

	for right := 0; right < n; right++ {
		rChar := rune(word[right])

		if !isVowel(rChar) {
			left = right + 1
			freq = make(map[rune]int)
			uniqueVowelCount = 0
			continue
		}

		if freq[rChar] == 0 {
			uniqueVowelCount++
		}
		freq[rChar]++

		for uniqueVowelCount > k {
			lChar := rune(word[left])
			freq[lChar]--
			if freq[lChar] == 0 {
				uniqueVowelCount--
			}
			left++
		}

		count += (right - left + 1)
	}
	return count
}
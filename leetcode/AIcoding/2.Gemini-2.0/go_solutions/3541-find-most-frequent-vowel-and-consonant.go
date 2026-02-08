func mostFrequentChar(s string) string {
	vowelCounts := map[rune]int{'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0}
	consonantCounts := map[rune]int{}
	maxVowelCount := 0
	maxConsonantCount := 0
	mostFrequentVowel := ""
	mostFrequentConsonant := ""

	for _, char := range s {
		char = rune(s[0] + (char - s[0])&^32)
		if _, ok := vowelCounts[char]; ok {
			vowelCounts[char]++
			if vowelCounts[char] > maxVowelCount {
				maxVowelCount = vowelCounts[char]
				mostFrequentVowel = string(char)
			} else if vowelCounts[char] == maxVowelCount && string(char) < mostFrequentVowel {
				mostFrequentVowel = string(char)
			}
		} else if char >= 'a' && char <= 'z' {
			consonantCounts[char]++
			if consonantCounts[char] > maxConsonantCount {
				maxConsonantCount = consonantCounts[char]
				mostFrequentConsonant = string(char)
			} else if consonantCounts[char] == maxConsonantCount && string(char) < mostFrequentConsonant {
				mostFrequentConsonant = string(char)
			}
		}
	}

	if mostFrequentVowel == "" && mostFrequentConsonant == "" {
		return ""
	} else if mostFrequentVowel == "" {
		return mostFrequentConsonant
	} else if mostFrequentConsonant == "" {
		return mostFrequentVowel
	} else if mostFrequentVowel < mostFrequentConsonant {
		return mostFrequentVowel
	} else {
		return mostFrequentConsonant
	}
}
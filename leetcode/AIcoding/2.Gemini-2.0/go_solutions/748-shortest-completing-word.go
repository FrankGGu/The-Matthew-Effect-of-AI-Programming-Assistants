import (
	"strings"
)

func shortestCompletingWord(licensePlate string, words []string) string {
	licensePlate = strings.ToLower(licensePlate)
	charCounts := make(map[rune]int)
	for _, char := range licensePlate {
		if char >= 'a' && char <= 'z' {
			charCounts[char]++
		}
	}

	shortest := ""
	for _, word := range words {
		wordLower := strings.ToLower(word)
		wordCounts := make(map[rune]int)
		for _, char := range wordLower {
			wordCounts[char]++
		}

		completes := true
		for char, count := range charCounts {
			if wordCounts[char] < count {
				completes = false
				break
			}
		}

		if completes {
			if shortest == "" || len(word) < len(shortest) {
				shortest = word
			}
		}
	}

	return shortest
}
import (
	"unicode"
)

func shortestCompletingWord(licensePlate string, words []string) string {
	plateCounts := make([]int, 26)
	for _, r := range licensePlate {
		if unicode.IsLetter(r) {
			plateCounts[unicode.ToLower(r)-'a']++
		}
	}

	shortestWord := ""

	for _, word := range words {
		wordCounts := make([]int, 26)
		for _, r := range word {
			wordCounts[r-'a']++
		}

		isCompleting := true
		for i := 0; i < 26; i++ {
			if wordCounts[i] < plateCounts[i] {
				isCompleting = false
				break
			}
		}

		if isCompleting {
			if shortestWord == "" || len(word) < len(shortestWord) {
				shortestWord = word
			}
		}
	}

	return shortestWord
}
import "strings"

func canBeTypedWords(text string, brokenLetters string) int {
	brokenMap := make(map[rune]bool)
	for _, char := range brokenLetters {
		brokenMap[char] = true
	}

	words := strings.Fields(text)
	typableWordCount := 0

	for _, word := range words {
		isTypable := true
		for _, char := range word {
			if brokenMap[char] {
				isTypable = false
				break
			}
		}
		if isTypable {
			typableWordCount++
		}
	}

	return typableWordCount
}
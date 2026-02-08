import "strings"

func canBeTypedWords(text string, brokenLetters string) int {
	broken := [26]bool{}
	for _, r := range brokenLetters {
		broken[r-'a'] = true
	}

	words := strings.Fields(text)
	count := 0

	for _, word := range words {
		canType := true
		for _, r := range word {
			if broken[r-'a'] {
				canType = false
				break
			}
		}
		if canType {
			count++
		}
	}

	return count
}
import "strings"

func canBeTypedWords(text string, brokenLetters string) int {
	words := strings.Split(text, " ")
	count := 0
	broken := make(map[rune]bool)
	for _, r := range brokenLetters {
		broken[r] = true
	}

	for _, word := range words {
		ok := true
		for _, r := range word {
			if broken[r] {
				ok = false
				break
			}
		}
		if ok {
			count++
		}
	}

	return count
}
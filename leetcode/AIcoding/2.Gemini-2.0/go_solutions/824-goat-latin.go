import (
	"strings"
)

func toGoatLatin(sentence string) string {
	words := strings.Split(sentence, " ")
	result := []string{}
	for i, word := range words {
		firstChar := strings.ToLower(string(word[0]))
		if firstChar == "a" || firstChar == "e" || firstChar == "i" || firstChar == "o" || firstChar == "u" {
			word += "ma"
		} else {
			word = word[1:] + string(word[0]) + "ma"
		}
		for j := 0; j <= i; j++ {
			word += "a"
		}
		result = append(result, word)
	}
	return strings.Join(result, " ")
}
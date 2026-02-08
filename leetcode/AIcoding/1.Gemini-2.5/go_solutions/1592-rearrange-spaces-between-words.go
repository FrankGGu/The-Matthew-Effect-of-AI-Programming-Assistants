import (
	"strings"
)

func reorderSpaces(text string) string {
	totalSpaces := 0
	for _, r := range text {
		if r == ' ' {
			totalSpaces++
		}
	}

	words := strings.Fields(text)
	numWords := len(words)

	if numWords == 0 {
		return strings.Repeat(" ", totalSpaces)
	}

	if numWords == 1 {
		return words[0] + strings.Repeat(" ", totalSpaces)
	}

	spacesBetweenWords := totalSpaces / (numWords - 1)
	trailingSpaces := totalSpaces % (numWords - 1)

	var builder strings.Builder
	for i, word := range words {
		builder.WriteString(word)
		if i < numWords-1 {
			builder.WriteString(strings.Repeat(" ", spacesBetweenWords))
		}
	}
	builder.WriteString(strings.Repeat(" ", trailingSpaces))

	return builder.String()
}
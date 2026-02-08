import (
	"strconv"
	"strings"
)

func compressString(word string) string {
	if len(word) == 0 {
		return ""
	}

	var builder strings.Builder
	n := len(word)
	i := 0

	for i < n {
		char := word[i]
		count := 0
		j := i
		for j < n && word[j] == char {
			count++
			j++
		}

		builder.WriteByte(char)
		if count > 1 {
			builder.WriteString(strconv.Itoa(count))
		}
		i = j
	}

	return builder.String()
}
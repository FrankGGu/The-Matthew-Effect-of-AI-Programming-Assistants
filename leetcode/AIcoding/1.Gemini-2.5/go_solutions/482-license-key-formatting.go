import (
	"strings"
	"unicode"
)

func licenseKeyFormatting(s string, k int) string {
	var cleanedChars []rune
	for _, r := range s {
		if r != '-' {
			cleanedChars = append(cleanedChars, unicode.ToUpper(r))
		}
	}

	n := len(cleanedChars)
	if n == 0 {
		return ""
	}

	var resultBuilder strings.Builder

	firstBlockLen := n % k
	if firstBlockLen == 0 {
		firstBlockLen = k
	}

	for i := 0; i < firstBlockLen; i++ {
		resultBuilder.WriteRune(cleanedChars[i])
	}

	for i := firstBlockLen; i < n; i += k {
		resultBuilder.WriteRune('-')
		for j := 0; j < k; j++ {
			resultBuilder.WriteRune(cleanedChars[i+j])
		}
	}

	return resultBuilder.String()
}
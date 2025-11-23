import (
	"fmt"
	"strconv"
	"strings"
)

func equalRational(s string, t string) bool {
	return normalize(s) == normalize(t)
}

func normalize(s string) string {
	if !strings.Contains(s, "(") {
		return s
	}

	parts := strings.Split(s, "(")
	integerAndDecimal := parts[0]
	repeating := strings.TrimSuffix(parts[1], ")")

	if repeating == "" {
		return integerAndDecimal
	}

	if len(repeating) > 6 {
		repeating = repeating[:6]
	}

	for i := 0; i < 10; i++ {
		integerAndDecimal += repeating
	}

	idx := strings.Index(integerAndDecimal, ".")
	if idx == -1 {
		return integerAndDecimal
	}

	integerPart := integerAndDecimal[:idx]
	decimalPart := integerAndDecimal[idx+1:]

	decimalPart = trimTrailingZeros(decimalPart)

	if decimalPart == "" {
		return integerPart
	}

	return integerPart + "." + decimalPart
}

func trimTrailingZeros(s string) string {
	i := len(s) - 1
	for i >= 0 && s[i] == '0' {
		i--
	}
	return s[:i+1]
}
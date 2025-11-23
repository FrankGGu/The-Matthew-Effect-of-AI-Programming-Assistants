import (
	"sort"
	"strings"
)

func smallestPalindrome(s string) string {
	counts := make(map[rune]int)
	for _, r := range s {
		counts[r]++
	}

	oddCount := 0
	oddChar := rune(0)
	for r, count := range counts {
		if count%2 != 0 {
			oddCount++
			oddChar = r
		}
	}

	if oddCount > 1 {
		return ""
	}

	var half []rune
	for r, count := range counts {
		for i := 0; i < count/2; i++ {
			half = append(half, r)
		}
	}

	sort.Slice(half, func(i, j int) bool {
		return half[i] < half[j]
	})

	var sb strings.Builder
	for _, r := range half {
		sb.WriteRune(r)
	}

	prefix := sb.String()
	suffix := reverseString(prefix)

	if oddChar != 0 {
		return prefix + string(oddChar) + suffix
	} else {
		return prefix + suffix
	}
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func main() {}
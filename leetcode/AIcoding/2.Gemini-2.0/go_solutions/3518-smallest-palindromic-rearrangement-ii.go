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

	var prefix []rune
	for r, count := range counts {
		for i := 0; i < count/2; i++ {
			prefix = append(prefix, r)
		}
	}

	sort.Slice(prefix, func(i, j int) bool {
		return prefix[i] < prefix[j]
	})

	var result strings.Builder
	for _, r := range prefix {
		result.WriteRune(r)
	}

	if oddChar != 0 {
		result.WriteRune(oddChar)
	}

	for i := len(prefix) - 1; i >= 0; i-- {
		result.WriteRune(prefix[i])
	}

	return result.String()
}
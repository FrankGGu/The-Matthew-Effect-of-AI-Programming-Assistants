import "strings"

func minimizedStringLength(s string) int {
	seen := make(map[rune]struct{})
	for _, char := range s {
		seen[char] = struct{}{}
	}
	return len(seen)
}
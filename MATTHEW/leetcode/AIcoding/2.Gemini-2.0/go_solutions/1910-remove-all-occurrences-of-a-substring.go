import "strings"

func removeOccurrences(s string, part string) string {
	for strings.Contains(s, part) {
		index := strings.Index(s, part)
		s = s[:index] + s[index+len(part):]
	}
	return s
}
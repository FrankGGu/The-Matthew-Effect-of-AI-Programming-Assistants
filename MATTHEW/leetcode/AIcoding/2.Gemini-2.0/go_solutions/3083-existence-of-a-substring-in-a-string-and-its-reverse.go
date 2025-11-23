import "strings"

func exist(a string, b string) bool {
	if strings.Contains(b, a) {
		return true
	}
	runes := []rune(a)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	reversedA := string(runes)
	if strings.Contains(b, reversedA) {
		return true
	}
	return false
}
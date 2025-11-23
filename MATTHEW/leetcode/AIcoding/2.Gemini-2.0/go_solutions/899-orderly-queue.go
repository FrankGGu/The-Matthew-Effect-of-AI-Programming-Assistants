import (
	"sort"
	"strings"
)

func orderlyQueue(s string, k int) string {
	if k > 1 {
		chars := []rune(s)
		sort.Slice(chars, func(i, j int) bool {
			return chars[i] < chars[j]
		})
		return string(chars)
	}

	res := s
	for i := 1; i < len(s); i++ {
		temp := s[i:] + s[:i]
		if temp < res {
			res = temp
		}
	}
	return res
}
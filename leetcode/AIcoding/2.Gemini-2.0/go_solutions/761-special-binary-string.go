import (
	"sort"
	"strings"
)

func makeLargestSpecial(s string) string {
	if len(s) == 0 {
		return ""
	}
	cnt := 0
	left := 0
	parts := []string{}
	for i := 0; i < len(s); i++ {
		if s[i] == '1' {
			cnt++
		} else {
			cnt--
		}
		if cnt == 0 {
			parts = append(parts, "1"+makeLargestSpecial(s[left+1:i])+"0")
			left = i + 1
		}
	}
	sort.Sort(sort.Reverse(sort.StringSlice(parts)))
	return strings.Join(parts, "")
}
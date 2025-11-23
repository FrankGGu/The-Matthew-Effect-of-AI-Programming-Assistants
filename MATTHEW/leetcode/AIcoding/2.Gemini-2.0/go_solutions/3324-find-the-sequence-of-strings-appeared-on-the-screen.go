import (
	"strings"
)

func findString(s []string) string {
	if len(s) == 0 {
		return ""
	}

	res := s[0]
	for i := 1; i < len(s); i++ {
		for !strings.HasPrefix(s[i], res) {
			res = res[1:]
			if len(res) == 0 {
				return ""
			}
		}
		if len(s[i]) > len(res) {
			res = s[i]
		}
	}
	return res
}
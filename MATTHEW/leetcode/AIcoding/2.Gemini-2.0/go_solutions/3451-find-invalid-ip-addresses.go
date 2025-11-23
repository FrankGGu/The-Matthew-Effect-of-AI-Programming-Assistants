import (
	"strconv"
	"strings"
)

func restoreIpAddresses(s string) []string {
	result := []string{}
	var backtrack func(index int, parts []string)
	backtrack = func(index int, parts []string) {
		if len(parts) == 4 {
			if index == len(s) {
				result = append(result, strings.Join(parts, "."))
			}
			return
		}

		for i := 1; i <= 3; i++ {
			if index+i > len(s) {
				break
			}
			part := s[index : index+i]
			num, err := strconv.Atoi(part)
			if err != nil {
				continue
			}
			if i > 1 && part[0] == '0' {
				continue
			}
			if num > 255 {
				continue
			}
			backtrack(index+i, append(parts, part))
		}
	}
	backtrack(0, []string{})
	return result
}
import (
	"strconv"
)

func restoreIpAddresses(s string) []string {
	result := []string{}
	var backtrack func(index int, dots int, currentIP string)

	backtrack = func(index int, dots int, currentIP string) {
		if dots == 4 {
			if index == len(s) {
				result = append(result, currentIP[:len(currentIP)-1])
			}
			return
		}

		for i := index; i < len(s) && i < index+3; i++ {
			segment := s[index : i+1]
			num, _ := strconv.Atoi(segment)

			if (segment[0] == '0' && len(segment) > 1) || num > 255 {
				continue
			}

			backtrack(i+1, dots+1, currentIP+segment+".")
		}
	}

	backtrack(0, 0, "")
	return result
}
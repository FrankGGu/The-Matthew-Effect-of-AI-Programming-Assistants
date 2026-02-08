import (
	"strconv"
	"strings"
)

func maxDiff(num int) int {
	s := strconv.Itoa(num)
	maxNum := findMax(s)
	minNum := findMin(s)

	maxInt, _ := strconv.Atoi(maxNum)
	minInt, _ := strconv.Atoi(minNum)

	return maxInt - minInt
}

func findMax(s string) string {
	for i := 0; i < len(s); i++ {
		if s[i] != '9' {
			oldChar := s[i]
			newStr := strings.ReplaceAll(s, string(oldChar), "9")
			return newStr
		}
	}
	return s
}

func findMin(s string) string {
	if s[0] != '1' {
		oldChar := s[0]
		var newStr string
		if oldChar == '0' {
			newStr = s
		} else {
			newStr = strings.ReplaceAll(s, string(oldChar), "1")
		}

		if newStr[0] == '0' && len(newStr) > 1 {
			return s
		}

		return newStr
	} else {
		for i := 1; i < len(s); i++ {
			if s[i] != '0' && s[i] != '1' {
				oldChar := s[i]
				newStr := strings.ReplaceAll(s, string(oldChar), "0")
				if newStr[0] == '0' && len(newStr) > 1 {
					continue
				}
				return newStr
			}
		}
		return s
	}
}
import (
	"strconv"
)

func isAdditiveNumber(num string) bool {
	n := len(num)
	for i := 1; i <= n/2; i++ {
		for j := 1; j <= (n-i)/2; j++ {
			if isAdditive(num, 0, i, j) {
				return true
			}
		}
	}
	return false
}

func isAdditive(num string, start, len1, len2 int) bool {
	if start+len1+len2 == len(num) {
		return true
	}
	if start+len1+len2 > len(num) {
		return false
	}

	num1, _ := strconv.Atoi(num[start : start+len1])
	num2, _ := strconv.Atoi(num[start+len1 : start+len1+len2])

	if len1 > 1 && num[start] == '0' {
		return false
	}
	if len2 > 1 && num[start+len1] == '0' {
		return false
	}
	sum := num1 + num2
	sumStr := strconv.Itoa(sum)

	if len(sumStr) > len(num)-start-len1-len2 {
		return false
	}

	if num[start+len1+len2:min(len(num), start+len1+len2+len(sumStr))] == sumStr {
		return isAdditive(num, start+len1, len2, len(sumStr))
	}
	return false
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
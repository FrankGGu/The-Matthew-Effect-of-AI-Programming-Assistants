import (
	"strconv"
	"strings"
)

func compareVersion(version1 string, version2 string) int {
	v1 := strings.Split(version1, ".")
	v2 := strings.Split(version2, ".")

	n1 := len(v1)
	n2 := len(v2)

	maxLen := max(n1, n2)

	for i := 0; i < maxLen; i++ {
		num1 := 0
		num2 := 0

		if i < n1 {
			val, _ := strconv.Atoi(v1[i])
			num1 = val
		}

		if i < n2 {
			val, _ := strconv.Atoi(v2[i])
			num2 = val
		}

		if num1 > num2 {
			return 1
		} else if num1 < num2 {
			return -1
		}
	}

	return 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
import (
	"strconv"
	"strings"
)

func digitSum(s string, k int) string {
	for len(s) > k {
		var sb strings.Builder
		currentSum := 0
		groupCount := 0

		for i := 0; i < len(s); i++ {
			currentSum += int(s[i] - '0')
			groupCount++

			if groupCount == k || i == len(s)-1 {
				sb.WriteString(strconv.Itoa(currentSum))
				currentSum = 0
				groupCount = 0
			}
		}
		s = sb.String()
	}
	return s
}
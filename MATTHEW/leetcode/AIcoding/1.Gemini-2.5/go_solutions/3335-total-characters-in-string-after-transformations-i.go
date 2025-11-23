import (
	"strconv"
	"strings"
)

func getLucky(s string, k int) int {
	var sb strings.Builder
	for _, char := range s {
		val := int(char - 'a' + 1)
		sb.WriteString(strconv.Itoa(val))
	}
	currentNumStr := sb.String()

	for i := 0; i < k; i++ {
		sum := 0
		for _, digitChar := range currentNumStr {
			sum += int(digitChar - '0')
		}
		if i == k-1 {
			return sum
		}
		currentNumStr = strconv.Itoa(sum)
	}

	return 0
}
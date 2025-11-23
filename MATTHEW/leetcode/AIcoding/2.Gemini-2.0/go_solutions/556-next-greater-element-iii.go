import (
	"sort"
	"strconv"
	"strings"
)

func nextGreaterElement(n int) int {
	s := strconv.Itoa(n)
	digits := strings.Split(s, "")
	l := len(digits)

	i := l - 2
	for i >= 0 && digits[i] >= digits[i+1] {
		i--
	}

	if i < 0 {
		return -1
	}

	j := l - 1
	for j > i && digits[j] <= digits[i] {
		j--
	}

	digits[i], digits[j] = digits[j], digits[i]

	sort.Strings(digits[i+1:])

	resStr := strings.Join(digits, "")
	res, err := strconv.Atoi(resStr)
	if err != nil || res > 2147483647 {
		return -1
	}

	return res
}
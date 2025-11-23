import (
	"strconv"
)

func divisorSubstrings(num int, k int) int {
	s := strconv.Itoa(num)
	n := len(s)
	count := 0

	for i := 0; i <= n-k; i++ {
		subStr := s[i : i+k]
		subInt, _ := strconv.Atoi(subStr)

		if subInt == 0 {
			continue
		}

		if num%subInt == 0 {
			count++
		}
	}

	return count
}
import (
	"strings"
)

func smallestNumber(pattern string) string {
	n := len(pattern)
	var sb strings.Builder
	stack := []int{}
	currentNum := 1

	for i := 0; i <= n; i++ {
		stack = append(stack, currentNum)
		currentNum++

		if i == n || pattern[i] == 'I' {
			for len(stack) > 0 {
				val := stack[len(stack)-1]
				stack = stack[:len(stack)-1]
				sb.WriteByte(byte('0' + val))
			}
		}
	}

	return sb.String()
}
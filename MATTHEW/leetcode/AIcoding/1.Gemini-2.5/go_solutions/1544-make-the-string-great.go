import "strings"

func makeGood(s string) string {
	stack := []rune{}

	for _, char := range s {
		if len(stack) > 0 {
			lastChar := stack[len(stack)-1]
			if lastChar != char && (lastChar == char+32 || lastChar == char-32) {
				stack = stack[:len(stack)-1]
			} else {
				stack = append(stack, char)
			}
		} else {
			stack = append(stack, char)
		}
	}

	return string(stack)
}
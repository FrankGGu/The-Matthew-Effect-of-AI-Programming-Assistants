func isRight(s string) bool {
	n := len(s)
	if n == 0 {
		return false
	}
	stack := make([]rune, 0)
	mapping := map[rune]rune{
		')': '(',
		']': '[',
		'}': '{',
	}
	for _, char := range s {
		switch char {
		case '(', '[', '{':
			stack = append(stack, char)
		case ')', ']', '}':
			if len(stack) == 0 {
				return false
			}
			top := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			if mapping[char] != top {
				return false
			}
		default:
			return false
		}
	}
	return len(stack) == 0
}
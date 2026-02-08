func reverseParentheses(s string) string {
	stack := []string{}
	currentString := ""
	for _, ch := range s {
		if ch == '(' {
			stack = append(stack, currentString)
			currentString = ""
		} else if ch == ')' {
			reversed := reverse(currentString)
			currentString = stack[len(stack)-1] + reversed
			stack = stack[:len(stack)-1]
		} else {
			currentString += string(ch)
		}
	}
	return currentString
}

func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}
func decodeString(s string) string {
	stack := []string{}
	for i := 0; i < len(s); i++ {
		if s[i] != ']' {
			stack = append(stack, string(s[i]))
		} else {
			str := ""
			for stack[len(stack)-1] != "[" {
				str = stack[len(stack)-1] + str
				stack = stack[:len(stack)-1]
			}
			stack = stack[:len(stack)-1]
			numStr := ""
			for len(stack) > 0 && isDigit(stack[len(stack)-1][0]) {
				numStr = stack[len(stack)-1] + numStr
				stack = stack[:len(stack)-1]
			}
			num := 0
			for _, c := range numStr {
				num = num*10 + int(c-'0')
			}
			repeatedStr := ""
			for j := 0; j < num; j++ {
				repeatedStr += str
			}
			stack = append(stack, repeatedStr)
		}
	}
	result := ""
	for _, str := range stack {
		result += str
	}
	return result
}

func isDigit(c byte) bool {
	return c >= '0' && c <= '9'
}
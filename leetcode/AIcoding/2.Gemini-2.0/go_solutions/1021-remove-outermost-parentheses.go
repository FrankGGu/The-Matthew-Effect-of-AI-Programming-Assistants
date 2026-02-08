func removeOuterParentheses(s string) string {
	res := ""
	balance := 0
	for _, char := range s {
		if char == '(' {
			if balance > 0 {
				res += string(char)
			}
			balance++
		} else {
			balance--
			if balance > 0 {
				res += string(char)
			}
		}
	}
	return res
}
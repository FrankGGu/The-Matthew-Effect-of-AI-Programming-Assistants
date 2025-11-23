package main

func decodeString(s string) string {
	var stack []string
	var currentNum int
	var currentStr string

	for i := 0; i < len(s); i++ {
		char := s[i]
		if char >= '0' && char <= '9' {
			currentNum = currentNum*10 + int(char-'0')
		} else if char == '[' {
			stack = append(stack, currentStr)
			stack = append(stack, strconv.Itoa(currentNum))
			currentStr = ""
			currentNum = 0
		} else if char == ']' {
			numStr := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			prevStr := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			num, _ := strconv.Atoi(numStr)
			currentStr = prevStr + strings.Repeat(currentStr, num)
		} else {
			currentStr += string(char)
		}
	}
	return currentStr
}
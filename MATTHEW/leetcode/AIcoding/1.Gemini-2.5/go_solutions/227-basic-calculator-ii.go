func calculate(s string) int {
	stack := []int{}
	currentNumber := 0
	operation := '+' // Default initial operation

	// Append a dummy operator to the end of the string.
	// This ensures that the last number and its preceding operation are processed.
	s = s + "+"

	for i := 0; i < len(s); i++ {
		char := s[i]

		if char >= '0' && char <= '9' {
			currentNumber = currentNumber*10 + int(char-'0')
		} else if char == ' ' {
			// Skip spaces
			continue
		} else { // It's an operator (+, -, *, /)
			switch operation {
			case '+':
				stack = append(stack, currentNumber)
			case '-':
				stack = append(stack, -currentNumber)
			case '*':
				lastNum := stack[len(stack)-1]
				stack = stack[:len(stack)-1] // Pop
				stack = append(stack, lastNum*currentNumber) // Push result
			case '/':
				lastNum := stack[len(stack)-1]
				stack = stack[:len(stack)-1] // Pop
				stack = append(stack, lastNum/currentNumber) // Push result
			}
			// Update the operation for the next number
			operation = rune(char)
			// Reset current number
			currentNumber = 0
		}
	}

	result := 0
	for _, num := range stack {
		result += num
	}
	return result
}
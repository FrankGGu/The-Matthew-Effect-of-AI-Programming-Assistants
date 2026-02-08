func evalRPN(tokens []string) int {
	stack := make([]int, 0)

	for _, token := range tokens {
		switch token {
		case "+":
			operand2 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			operand1 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			stack = append(stack, operand1+operand2)
		case "-":
			operand2 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			operand1 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			stack = append(stack, operand1-operand2)
		case "*":
			operand2 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			operand1 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			stack = append(stack, operand1*operand2)
		case "/":
			operand2 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			operand1 := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			stack = append(stack, operand1/operand2)
		default:
			num, _ := strconv.Atoi(token)
			stack = append(stack, num)
		}
	}

	return stack[0]
}
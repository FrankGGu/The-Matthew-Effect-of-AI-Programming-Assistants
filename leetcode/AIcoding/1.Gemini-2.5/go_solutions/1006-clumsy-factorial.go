package main

func clumsy(n int) int {
	if n == 0 {
		return 0 // Problem constraints state n is a positive integer, so n >= 1. This case is technically not reachable.
	}

	// Use a stack to handle operator precedence.
	// Operations follow the pattern: *, /, +, -
	// When '*' or '/' is encountered, apply it to the last number on the stack.
	// When '+' or '-' is encountered, push the current number (or its negative for '-') onto the stack.
	// Finally, sum all numbers in the stack.

	stack := []int{n} // Initialize stack with the first number n
	opIndex := 0      // 0: *, 1: /, 2: +, 3: -

	for i := n - 1; i >= 1; i-- {
		currentNum := i
		switch opIndex % 4 {
		case 0: // Multiply (*)
			prev := stack[len(stack)-1]
			stack = stack[:len(stack)-1] // Pop
			stack = append(stack, prev*currentNum)
		case 1: // Divide (/)
			prev := stack[len(stack)-1]
			stack = stack[:len(stack)-1] // Pop
			stack = append(stack, prev/currentNum)
		case 2: // Add (+)
			stack = append(stack, currentNum)
		case 3: // Subtract (-)
			stack = append(stack, -currentNum) // Push negative to handle subtraction during final sum
		}
		opIndex++
	}

	result := 0
	for _, num := range stack {
		result += num
	}

	return result
}
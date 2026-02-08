package main

import (
	"math"
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minCostToChangeFinalValue(expression string) int {
	operandStack := make([][2]int, 0) // Stores [cost_to_be_0, cost_to_be_1]
	operatorStack := make([]byte, 0)   // Stores operators and '('

	// Helper function to apply an operator from the stack
	applyOp := func() {
		op := operatorStack[len(operatorStack)-1]
		operatorStack = operatorStack[:len(operatorStack)-1] // Pop operator

		rightCosts := operandStack[len(operandStack)-1]
		operandStack = operandStack[:len(operandStack)-1] // Pop right operand
		leftCosts := operandStack[len(operandStack)-1]
		operandStack = operandStack[:len(operandStack)-1] // Pop left operand

		newCosts := [2]int{math.MaxInt32, math.MaxInt32}

		if op == '&' {
			// Current operator is '&'
			// Cost to make result 0: (0&0), (0&1), (1&0)
			c0_and := min(leftCosts[0]+rightCosts[0], min(leftCosts[0]+rightCosts[1], leftCosts[1]+rightCosts[0]))
			// Cost to make result 1: (1&1)
			c1_and := leftCosts[1] + rightCosts[1]

			newCosts[0] = c0_and
			newCosts[1] = c1_and

			// Consider changing '&' to '|' (cost +1)
			// Cost to make result 0 if op becomes '|': (0|0)
			c0_or_changed := leftCosts[0] + rightCosts[0]
			// Cost to make result 1 if op becomes '|': (0|1), (1|0), (1|1)
			c1_or_changed := min(leftCosts[0]+rightCosts[1], min(leftCosts[1]+rightCosts[0], leftCosts[1]+rightCosts[1]))

			newCosts[0] = min(newCosts[0], 1+c0_or_changed)
			newCosts[1] = min(newCosts[1], 1+c1_or_changed)

		} else { // op == '|'
			// Current operator is '|'
			// Cost to make result 0: (0|0)
			c0_or := leftCosts[0] + rightCosts[0]
			// Cost to make result 1: (0|1), (1|0), (1|1)
			c1_or := min(leftCosts[0]+rightCosts[1], min(leftCosts[1]+rightCosts[0], leftCosts[1]+rightCosts[1]))

			newCosts[0] = c0_or
			newCosts[1] = c1_or

			// Consider changing '|' to '&' (cost +1)
			// Cost to make result 0 if op becomes '&': (0&0), (0&1), (1&0)
			c0_and_changed := min(leftCosts[0]+rightCosts[0], min(leftCosts[0]+rightCosts[1], leftCosts[1]+rightCosts[0]))
			// Cost to make result 1 if op becomes '&': (1&1)
			c1_and_changed := leftCosts[1] + rightCosts[1]

			newCosts[0] = min(newCosts[0], 1+c0_and_changed)
			newCosts[1] = min(newCosts[1], 1+c1_and_changed)
		}
		operandStack = append(operandStack, newCosts) // Push result back to operand stack
	}

	for i := 0; i < len(expression); i++ {
		char := expression[i]
		if char == '0' {
			operandStack = append(operandStack, [2]int{0, 1}) // Cost to be 0 is 0, cost to be 1 is 1
		} else if char == '1' {
			operandStack = append(operandStack, [2]int{1, 0}) // Cost to be 0 is 1, cost to be 1 is 0
		} else if char == '(' {
			operatorStack = append(operatorStack, char)
		} else if char == ')' {
			// Process operators until '(' is found
			for operatorStack[len(operatorStack)-1] != '(' {
				applyOp()
			}
			operatorStack = operatorStack[:len(operatorStack)-1] // Pop '('
		} else { // char == '&' or '|'
			// For left-to-right evaluation, apply any pending operators
			// that are not '('
			for len(operatorStack) > 0 && operatorStack[len(operatorStack)-1] != '(' {
				applyOp()
			}
			operatorStack = append(operatorStack, char)
		}
	}

	// Apply any remaining operators
	for len(operatorStack) > 0 {
		applyOp()
	}

	// The final result is on the operand stack
	resultCosts := operandStack[0]
	return min(resultCosts[0], resultCosts[1])
}
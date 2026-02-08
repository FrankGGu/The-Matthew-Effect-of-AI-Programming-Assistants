package main

func parseBoolExpr(expression string) bool {
	var parse func(int) (bool, int)
	parse = func(start int) (bool, int) {
		char := expression[start]

		if char == 't' {
			return true, start + 1
		}
		if char == 'f' {
			return false, start + 1
		}

		// It must be an operator: '!', '&', or '|'
		operator := char
		currentIdx := start + 2 // Skip operator and '('

		if operator == '!' {
			val, nextIdx := parse(currentIdx)
			return !val, nextIdx + 1 // nextIdx points to ')', skip it
		}

		var result bool
		if operator == '&' {
			result = true // Initial value for AND
		} else { // operator == '|'
			result = false // Initial value for OR
		}

		for {
			val, nextIdx := parse(currentIdx)

			if operator == '&' {
				result = result && val
			} else { // operator == '|'
				result = result || val
			}

			currentIdx = nextIdx

			// Check if there are more arguments or if we reached the closing parenthesis
			if expression[currentIdx] == ',' {
				currentIdx++ // Skip ',' to parse the next argument
			} else { // Must be ')'
				break
			}
		}

		return result, currentIdx + 1 // currentIdx points to ')', skip it
	}

	val, _ := parse(0)
	return val
}
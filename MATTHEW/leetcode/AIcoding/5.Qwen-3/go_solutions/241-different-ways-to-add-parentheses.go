package main

func diffWaysToAddParentheses(expression string) []int {
	if len(expression) == 0 {
		return nil
	}
	result := make([]int, 0)
	for i := 0; i < len(expression); i++ {
		if expression[i] == '+' || expression[i] == '-' || expression[i] == '*' {
			left := diffWaysToAddParentheses(expression[:i])
			right := diffWaysToAddParentheses(expression[i+1:])
			for _, l := range left {
				for _, r := range right {
					switch expression[i] {
					case '+':
						result = append(result, l+r)
					case '-':
						result = append(result, l-r)
					case '*':
						result = append(result, l*r)
					}
				}
			}
		}
	}
	if len(result) == 0 {
		num, _ := strconv.Atoi(expression)
		result = append(result, num)
	}
	return result
}
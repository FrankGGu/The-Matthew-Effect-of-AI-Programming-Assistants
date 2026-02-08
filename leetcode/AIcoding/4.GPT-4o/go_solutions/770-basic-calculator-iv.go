package main

import (
	"fmt"
	"strings"
)

func basicCalculatorIV(expression string, evalvars []string, evalints []int) map[string]int {
	variables := make(map[string]int)
	for i := 0; i < len(evalvars); i++ {
		variables[evalvars[i]] = evalints[i]
	}

	var stack []string
	var ops []rune
	var num string

	for i := 0; i < len(expression); i++ {
		if expression[i] == ' ' {
			continue
		}
		if expression[i] >= '0' && expression[i] <= '9' {
			num += string(expression[i])
		} else {
			if num != "" {
				stack = append(stack, num)
				num = ""
			}
			if expression[i] == '(' {
				ops = append(ops, '(')
			} else if expression[i] == ')' {
				for len(ops) > 0 && ops[len(ops)-1] != '(' {
					stack = append(stack, string(ops[len(ops)-1]))
					ops = ops[:len(ops)-1]
				}
				ops = ops[:len(ops)-1]
			} else if expression[i] == '+' || expression[i] == '-' || expression[i] == '*' {
				for len(ops) > 0 && precedence(ops[len(ops)-1]) >= precedence(rune(expression[i])) {
					stack = append(stack, string(ops[len(ops)-1]))
					ops = ops[:len(ops)-1]
				}
				ops = append(ops, rune(expression[i]))
			} else {
				var varName string
				for i < len(expression) && (expression[i] >= 'a' && expression[i] <= 'z') {
					varName += string(expression[i])
					i++
				}
				i--
				stack = append(stack, varName)
			}
		}
	}

	if num != "" {
		stack = append(stack, num)
	}

	for len(ops) > 0 {
		stack = append(stack, string(ops[len(ops)-1]))
		ops = ops[:len(ops)-1]
	}

	return evaluate(stack, variables)
}

func precedence(op rune) int {
	if op == '+' || op == '-' {
		return 1
	}
	if op == '*' {
		return 2
	}
	return 0
}

func evaluate(stack []string, variables map[string]int) map[string]int {
	result := make(map[string]int)
	terms := make(map[string]int)

	for i := 0; i < len(stack); i++ {
		if stack[i] == "+" || stack[i] == "-" || stack[i] == "*" {
			op := stack[i]
			var a, b string
			if i > 0 {
				a = stack[i-1]
			}
			if i+1 < len(stack) {
				b = stack[i+1]
			}
			if op == "+" {
				terms[a] += terms[b]
			} else if op == "-" {
				terms[a] -= terms[b]
			} else if op == "*" {
				terms[a] *= terms[b]
			}
			i++
		} else {
			if val, ok := variables[stack[i]]; ok {
				terms[stack[i]] += val
			} else {
				terms[stack[i]]++
			}
		}
	}

	for k, v := range terms {
		if v != 0 {
			result[k] = v
		}
	}
	return result
}

func main() {
	expression := "e + 8 - a + 5"
	evalvars := []string{"e"}
	evalints := []int{1}
	result := basicCalculatorIV(expression, evalvars, evalints)
	fmt.Println(result)
}
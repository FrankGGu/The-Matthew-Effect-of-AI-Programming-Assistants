package main

import (
	"strconv"
)

func diffWaysToCompute(expression string) []int {
	memo := make(map[string][]int)
	return computeWithMemo(expression, memo)
}

func computeWithMemo(expression string, memo map[string][]int) []int {
	if val, ok := memo[expression]; ok {
		return val
	}

	res := []int{}
	hasOperator := false

	for i, r := range expression {
		if r == '+' || r == '-' || r == '*' {
			hasOperator = true
			leftResults := computeWithMemo(expression[:i], memo)
			rightResults := computeWithMemo(expression[i+1:], memo)

			for _, leftVal := range leftResults {
				for _, rightVal := range rightResults {
					switch r {
					case '+':
						res = append(res, leftVal+rightVal)
					case '-':
						res = append(res, leftVal-rightVal)
					case '*':
						res = append(res, leftVal*rightVal)
					}
				}
			}
		}
	}

	if !hasOperator {
		val, _ := strconv.Atoi(expression)
		res = append(res, val)
	}

	memo[expression] = res
	return res
}
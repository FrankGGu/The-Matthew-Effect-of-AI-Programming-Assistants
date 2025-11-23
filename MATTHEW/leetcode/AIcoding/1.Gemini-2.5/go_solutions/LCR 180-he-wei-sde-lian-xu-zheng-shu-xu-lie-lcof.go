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

func mctFromLeafValues(arr []int) int {
	res := 0
	stack := []int{math.MaxInt32}

	for _, a := range arr {
		for stack[len(stack)-1] <= a {
			mid := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			res += mid * min(stack[len(stack)-1], a)
		}
		stack = append(stack, a)
	}

	for len(stack) > 2 {
		mid := stack[len(stack)-1]
		stack = stack[:len(stack)-1]
		res += mid * stack[len(stack)-1]
	}

	return res
}
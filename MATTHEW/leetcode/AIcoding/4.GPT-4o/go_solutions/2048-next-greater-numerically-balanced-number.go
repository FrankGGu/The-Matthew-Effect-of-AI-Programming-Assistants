package main

import (
	"fmt"
	"strconv"
)

func nextGreaterNumericallyBalancedNumber(n int) int {
	s := strconv.Itoa(n)
	length := len(s)

	for i := length - 1; i > 0; i-- {
		if s[i] > s[i-1] {
			for j := length - 1; j >= i; j-- {
				if s[j] > s[i-1] {
					s = swap(s, i-1, j)
					s = s[:i] + sorted(s[i:])
					result, _ := strconv.Atoi(s)
					if result > n {
						return result
					}
					break
				}
			}
			break
		}
	}
	return -1
}

func swap(s string, i, j int) string {
	runes := []rune(s)
	runes[i], runes[j] = runes[j], runes[i]
	return string(runes)
}

func sorted(s string) string {
	runes := []rune(s)
	for i := 0; i < len(runes)-1; i++ {
		for j := i + 1; j < len(runes); j++ {
			if runes[i] > runes[j] {
				runes[i], runes[j] = runes[j], runes[i]
			}
		}
	}
	return string(runes)
}

func main() {
	fmt.Println(nextGreaterNumericallyBalancedNumber(1234)) // Example input
}
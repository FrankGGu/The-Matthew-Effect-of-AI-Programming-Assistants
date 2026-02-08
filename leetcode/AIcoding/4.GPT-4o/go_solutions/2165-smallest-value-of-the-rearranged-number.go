package main

import (
	"fmt"
	"math"
	"sort"
	"strconv"
)

func smallestNumber(num int) string {
	if num == 0 {
		return "0"
	}

	isNegative := num < 0
	if isNegative {
		num = -num
	}

	digits := []int{}
	for num > 0 {
		digits = append(digits, num%10)
		num /= 10
	}

	sort.Ints(digits)

	if isNegative {
		result := ""
		for i := len(digits) - 1; i >= 0; i-- {
			result += strconv.Itoa(digits[i])
		}
		return "-" + result
	}

	if digits[0] == 0 {
		for i := 1; i < len(digits); i++ {
			if digits[i] != 0 {
				digits[0], digits[i] = digits[i], digits[0]
				break
			}
		}
	}

	result := ""
	for _, digit := range digits {
		result += strconv.Itoa(digit)
	}
	return result
}

func main() {
	fmt.Println(smallestNumber(310))   // Output: "103"
	fmt.Println(smallestNumber(-7605)) // Output: "-7650"
}
package main

import (
	"sort"
	"strconv"
)

func largestNumberAfterDigitSwaps(num int) int {
	s := strconv.Itoa(num)
	n := len(s)

	var oddDigits []int
	var evenDigits []int

	originalDigits := make([]int, n)

	for i := 0; i < n; i++ {
		digit := int(s[i] - '0')
		originalDigits[i] = digit

		if digit%2 == 0 {
			evenDigits = append(evenDigits, digit)
		} else {
			oddDigits = append(oddDigits, digit)
		}
	}

	sort.Slice(oddDigits, func(i, j int) bool {
		return oddDigits[i] > oddDigits[j]
	})
	sort.Slice(evenDigits, func(i, j int) bool {
		return evenDigits[i] > evenDigits[j]
	})

	result := 0
	oddPtr := 0
	evenPtr := 0

	for i := 0; i < n; i++ {
		digit := originalDigits[i]

		result *= 10
		if digit%2 == 0 {
			result += evenDigits[evenPtr]
			evenPtr++
		} else {
			result += oddDigits[oddPtr]
			oddPtr++
		}
	}

	return result
}
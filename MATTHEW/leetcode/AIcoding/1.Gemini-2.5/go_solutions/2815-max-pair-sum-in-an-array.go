package main

import (
	"math"
)

func getMaxDigit(n int) int {
	maxD := 0
	if n == 0 {
		return 0
	}
	for n > 0 {
		digit := n % 10
		if digit > maxD {
			maxD = digit
		}
		n /= 10
	}
	return maxD
}

func maxPairSum(nums []int) int {
	firstLargest := make([]int, 10)
	secondLargest := make([]int, 10)

	for _, num := range nums {
		maxD := getMaxDigit(num)
		if num > firstLargest[maxD] {
			secondLargest[maxD] = firstLargest[maxD]
			firstLargest[maxD] = num
		} else if num > secondLargest[maxD] {
			secondLargest[maxD] = num
		}
	}

	maxOverallSum := -1

	for d := 0; d < 10; d++ {
		if firstLargest[d] != 0 && secondLargest[d] != 0 {
			currentSum := firstLargest[d] + secondLargest[d]
			maxOverallSum = int(math.Max(float64(maxOverallSum), float64(currentSum)))
		}
	}

	return maxOverallSum
}
package main

import (
	"math"
	"strconv"
)

func reorderedPowerOf2(n int) bool {
	count := make([]int, 10)
	for n > 0 {
		count[n%10]++
		n /= 10
	}
	for i := 0; i < 31; i++ {
		temp := int(math.Pow(2, float64(i)))
		tempCount := make([]int, 10)
		for temp > 0 {
			tempCount[temp%10]++
			temp /= 10
		}
		if equal(count, tempCount) {
			return true
		}
	}
	return false
}

func equal(a, b []int) bool {
	for i := 0; i < 10; i++ {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}
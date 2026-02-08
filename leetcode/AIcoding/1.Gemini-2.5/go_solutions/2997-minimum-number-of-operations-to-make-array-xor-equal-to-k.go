package main

import "math/bits"

func minOperations(nums []int, k int) int {
	currentXOR := 0
	for _, num := range nums {
		currentXOR ^= num
	}

	diff := currentXOR ^ k

	return bits.OnesCount(uint(diff))
}
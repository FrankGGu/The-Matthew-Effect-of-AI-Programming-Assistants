package main

import (
	"math/bits"
)

func countPrimeSetBits(left int, right int) int {
	primeSet := map[int]bool{
		2:  true,
		3:  true,
		5:  true,
		7:  true,
		11: true,
		13: true,
		17: true,
		19: true,
	}

	ans := 0
	for i := left; i <= right; i++ {
		setBits := bits.OnesCount(uint(i))
		if primeSet[setBits] {
			ans++
		}
	}
	return ans
}
package main

import (
	"math/bits"
)

func countBeautifulSplits(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	prefixXOR := make([]int, n+1)
	for k := 1; k <= n; k++ {
		prefixXOR[k] = prefixXOR[k-1] ^ nums[k-1]
	}

	isPrefixBeautiful := make([]bool, n+1)
	for k := 0; k <= n; k++ {
		isPrefixBeautiful[k] = (bits.OnesCount(uint(prefixXOR[k])) % 2 == 0)
	}

	suffixXOR := make([]int, n+1)
	for k := n - 1; k >= 0; k-- {
		suffixXOR[k] = suffixXOR[k+1] ^ nums[k]
	}

	isSuffixBeautiful := make([]bool, n+1)
	for k := 0; k <= n; k++ {
		isSuffixBeautiful[k] = (bits.OnesCount(uint(suffixXOR[k])) % 2 == 0)
	}

	suffixBeautifulCount := make([]int, n+2)
	for k := n - 1; k >= 0; k-- {
		suffixBeautifulCount[k] = suffixBeautifulCount[k+1]
		if isSuffixBeautiful[k] {
			suffixBeautifulCount[k]++
		}
	}

	nextOne := make([]int, n+1)
	nextOne[n] = n
	for k := n - 1; k >= 0; k-- {
		if nums[k] == 1 {
			nextOne[k] = k
		} else {
			nextOne[k] = nextOne[k+1]
		}
	}

	totalBeautifulSplits := 0

	for i := 0; i <= n-2; i++ {
		if isPrefixBeautiful[i+1] {
			firstOneAfterI := nextOne[i+1]

			maxJForI := min(n-1, firstOneAfterI)

			if i+1 <= maxJForI {
				countForThisI := suffixBeautifulCount[i+1] - suffixBeautifulCount[maxJForI+1]
				totalBeautifulSplits += countForThisI
			}
		}
	}

	return totalBeautifulSplits
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
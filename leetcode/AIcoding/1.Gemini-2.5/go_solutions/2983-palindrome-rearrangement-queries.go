package main

import (
	"math/bits"
)

func canMakePaliQueries(s string, queries [][]int) []bool {
	n := len(s)
	prefixMasks := make([]int, n+1)
	for i := 0; i < n; i++ {
		charBit := 1 << (s[i] - 'a')
		prefixMasks[i+1] = prefixMasks[i] ^ charBit
	}

	results := make([]bool, len(queries))
	for i, query := range queries {
		left, right, k := query[0], query[1], query[2]

		subMask := prefixMasks[right+1] ^ prefixMasks[left]

		oddCounts := bits.OnesCount(uint(subMask))

		changesNeeded := oddCounts / 2

		results[i] = changesNeeded <= k
	}

	return results
}
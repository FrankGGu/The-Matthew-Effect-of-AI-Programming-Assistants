package main

import (
	"sort"
)

func countWays(ranges [][]int) int {
	if len(ranges) == 0 {
		return 1
	}

	sort.Slice(ranges, func(i, j int) bool {
		return ranges[i][0] < ranges[j][0]
	})

	const MOD = 1_000_000_007

	numGroups := 1
	currentEnd := ranges[0][1]

	for i := 1; i < len(ranges); i++ {
		start, end := ranges[i][0], ranges[i][1]
		if start > currentEnd {
			numGroups++
			currentEnd = end
		} else {
			if end > currentEnd {
				currentEnd = end
			}
		}
	}

	result := 1
	base := 2
	exponent := numGroups

	for exponent > 0 {
		if exponent%2 == 1 {
			result = (result * base) % MOD
		}
		base = (base * base) % MOD
		exponent /= 2
	}

	return result
}
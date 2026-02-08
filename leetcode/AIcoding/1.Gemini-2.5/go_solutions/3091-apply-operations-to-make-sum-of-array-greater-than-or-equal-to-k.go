package main

import "math"

func minOperations(k int) int {
	if k == 1 {
		return 0
	}

	minOps := k - 1

	for x := 1; x*x <= k; x++ {
		vMin := (k + x - 1) / x
		currentOps := (x - 1) + (vMin - 1)

		if currentOps < minOps {
			minOps = currentOps
		}
	}

	return minOps
}
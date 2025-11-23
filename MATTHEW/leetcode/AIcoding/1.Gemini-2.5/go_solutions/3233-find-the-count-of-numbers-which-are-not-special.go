package main

import (
	"math"
)

func notSpecialCount(l int, r int) int {
	maxSqrtR := int(math.Sqrt(float64(r)))

	isPrime := make([]bool, maxSqrtR+1)
	for i := 2; i <= maxSqrtR; i++ {
		isPrime[i] = true
	}

	for p := 2; p*p <= maxSqrtR; p++ {
		if isPrime[p] {
			for i := p * p; i <= maxSqrtR; i += p {
				isPrime[i] = false
			}
		}
	}

	specialCount := 0
	for p := 2; p <= maxSqrtR; p++ {
		if isPrime[p] {
			square := int64(p) * int64(p)
			if square >= int64(l) && square <= int64(r) {
				specialCount++
			}
		}
	}

	return (r - l + 1) - specialCount
}
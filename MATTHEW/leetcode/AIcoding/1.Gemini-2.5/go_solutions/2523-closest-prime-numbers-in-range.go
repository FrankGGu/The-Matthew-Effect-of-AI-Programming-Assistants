package main

import (
	"math"
)

func closestPrimes(left int, right int) []int {
	isPrime := make([]bool, right+1)
	for i := 0; i <= right; i++ {
		isPrime[i] = true
	}
	if right >= 0 {
		isPrime[0] = false
	}
	if right >= 1 {
		isPrime[1] = false
	}

	for p := 2; p*p <= right; p++ {
		if isPrime[p] {
			for i := p * p; i <= right; i += p {
				isPrime[i] = false
			}
		}
	}

	var primesInRange []int
	for i := left; i <= right; i++ {
		if isPrime[i] {
			primesInRange = append(primesInRange, i)
		}
	}

	if len(primesInRange) < 2 {
		return []int{-1, -1}
	}

	minDiff := math.MaxInt32
	result := []int{-1, -1}

	for i := 0; i < len(primesInRange)-1; i++ {
		p1 := primesInRange[i]
		p2 := primesInRange[i+1]
		diff := p2 - p1

		if diff < minDiff {
			minDiff = diff
			result[0] = p1
			result[1] = p2
		}
	}

	return result
}
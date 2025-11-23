package main

import "fmt"

func nthSuperUglyNumber(n int, primes []int) int {
	ugly := make([]int, n)
	ugly[0] = 1
	pointers := make([]int, len(primes))
	for i := range pointers {
		pointers[i] = 0
	}
	for i := 1; i < n; i++ {
		minVal := int(^uint(0) >> 1)
		for j := 0; j < len(primes); j++ {
			if ugly[pointers[j]]*primes[j] < minVal {
				minVal = ugly[pointers[j]] * primes[j]
			}
		}
		for j := 0; j < len(primes); j++ {
			if ugly[pointers[j]]*primes[j] == minVal {
				pointers[j]++
			}
		}
		ugly[i] = minVal
	}
	return ugly[n-1]
}
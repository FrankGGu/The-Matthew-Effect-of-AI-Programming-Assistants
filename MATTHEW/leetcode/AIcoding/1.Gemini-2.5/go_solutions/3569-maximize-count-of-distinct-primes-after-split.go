package main

import (
	"math"
)

func sieve(limit int) []int {
	isPrime := make([]bool, limit+1)
	for i := 2; i <= limit; i++ {
		isPrime[i] = true
	}
	for p := 2; p*p <= limit; p++ {
		if isPrime[p] {
			for i := p * p; i <= limit; i += p {
				isPrime[i] = false
			}
		}
	}
	primes := []int{}
	for i := 2; i <= limit; i++ {
		if isPrime[i] {
			primes = append(primes, i)
		}
	}
	return primes
}

func getDistinctPrimeFactors(num int, primes []int) map[int]bool {
	factors := make(map[int]bool)
	if num <= 1 {
		return factors
	}
	temp := num
	for _, p := range primes {
		if p*p > temp {
			break
		}
		if temp%p == 0 {
			factors[p] = true
			for temp%p == 0 {
				temp /= p
			}
		}
	}
	if temp > 1 { // If temp is still greater than 1, it's a prime factor itself
		factors[temp] = true
	}
	return factors
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxDistinctPrimesAfterSplit(n int) int {
	if n <= 1 {
		return 0 // a and b must be non-empty, so n must be at least 2.
	}

	// Precompute primes up to sqrt(10^9) = ~31622.
	// This limit is sufficient for factorizing numbers up to 10^9.
	sieveLimit := int(math.Sqrt(float64(1000000000))) + 1
	primes := sieve(sieveLimit)

	maxCount := 0

	// List of primorials (product of first k primes)
	// These numbers tend to have many distinct prime factors.
	primorials := []int{
		2, // P_1#
		6, // P_2#
		30, // P_3#
		210, // P_4#
		2310, // P_5#
		30030, // P_6#
		510510, // P_7#
		9699690, // P_8#
		223092870, // P_9#
	}

	// Candidates for 'a' to check:
	// 1. Small values of 'a' (up to a certain limit)
	// 2. Primorials (as 'a' or 'b' = n - 'a')
	// 3. n/2 if n is even
	candidateAValues := make(map[int]bool)

	// Add small 'a' values
	// A limit of 1000 for 'a' is a common heuristic for such problems.
	// The maximum possible number of distinct prime factors is relatively small (at most 15 for N=10^9),
	// so the optimal split often involves at least one small number.
	limitA := min(n-1, 1000)
	for i := 1; i <= limitA; i++ {
		candidateAValues[i] = true
	}

	// Add primorials as 'a'
	for _, p := range primorials {
		if p >= n {
			break
		}
		candidateAValues[p] = true
	}

	// Add 'n - primorials' as 'a'
	for _, p := range primorials {
		if p >= n {
			break
		}
		if n-p >= 1 { // Ensure b is non-empty
			candidateAValues[n-p] = true
		}
	}

	// Add n/2 if n is even, as this is a common split for maximizing factors.
	if n%2 == 0 && n/2 >= 1 {
		candidateAValues[n/2] = true
	}

	for a := range candidateAValues {
		if a <= 0 || a >= n { // Ensure a is valid (1 <= a < n)
			continue
		}
		b := n - a
		if b <= 0 { // Ensure b is valid (1 <= b < n)
			continue
		}

		factorsA := getDistinctPrimeFactors(a, primes)
		factorsB := getDistinctPrimeFactors(b, primes)

		combinedFactors := make(map[int]bool)
		for p := range factorsA {
			combinedFactors[p] = true
		}
		for p := range factorsB {
			combinedFactors[p] = true
		}
		maxCount = max(maxCount, len(combinedFactors))
	}

	return maxCount
}
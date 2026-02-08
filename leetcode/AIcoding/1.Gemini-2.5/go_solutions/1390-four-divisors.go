package main

import "math"

func sumFourDivisors(nums []int) int {
	totalSum := 0

	for _, n := range nums {
		count := 0
		currentSum := 0

		limit := int(math.Sqrt(float64(n)))
		for i := 1; i <= limit; i++ {
			if n%i == 0 {
				count++
				currentSum += i

				if i*i != n {
					count++
					currentSum += n / i
				}
			}
			// Optimization: if we've already found more than 4 divisors,
			// this number cannot have exactly four, so we can stop early.
			if count > 4 {
				break
			}
		}

		if count == 4 {
			totalSum += currentSum
		}
	}

	return totalSum
}
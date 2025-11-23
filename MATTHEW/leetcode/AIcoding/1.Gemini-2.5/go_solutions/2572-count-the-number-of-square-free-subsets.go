package main

const MOD = 1_000_000_007

func countSquareFreeSubsets(nums []int) int {
	primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
	numPrimes := len(primes)

	dp := make([]int, 1<<numPrimes)
	dp[0] = 1

	countOnes := 0

	for _, num := range nums {
		if num == 1 {
			countOnes++
			continue
		}

		currentMask := 0
		isSquareFree := true
		tempNum := num

		for i := 0; i < numPrimes; i++ {
			p := primes[i]
			if tempNum%p == 0 {
				currentMask |= (1 << i)
				tempNum /= p
				if tempNum%p == 0 {
					isSquareFree = false
					break
				}
			}
		}

		if !isSquareFree {
			continue
		}

		for mask := (1 << numPrimes) - 1; mask >= 0; mask-- {
			if (mask & currentMask) == 0 {
				dp[mask|currentMask] = (dp[mask|currentMask] + dp[mask]) % MOD
			}
		}
	}

	totalWaysFromOthers := 0
	for _, val := range dp {
		totalWaysFromOthers = (totalWaysFromOthers + val) % MOD
	}

	powerOfTwoOnes := 1
	for i := 0; i < countOnes; i++ {
		powerOfTwoOnes = (powerOfTwoOnes * 2) % MOD
	}

	result := (totalWaysFromOthers * powerOfTwoOnes) % MOD
	result = (result - 1 + MOD) % MOD

	return result
}
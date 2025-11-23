package main

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func subarrayLCM(nums []int, k int) int {
	n := len(nums)
	count := 0

	for i := 0; i < n; i++ {
		currentLCM := 1
		for j := i; j < n; j++ {
			num := nums[j]

			if num > k {
				break
			}

			// Calculate GCD
			commonDivisor := gcd(currentLCM, num)

			// Calculate new LCM
			// To avoid potential overflow for intermediate products before division,
			// use (currentLCM / commonDivisor) * num.
			// Given constraints (nums[i], k <= 1000), currentLCM will also not exceed k,
			// so currentLCM * num could be at most 1000 * 1000 = 1,000,000, which fits in int.
			newLCM := (currentLCM / commonDivisor) * num

			if newLCM > k {
				break
			}

			currentLCM = newLCM

			if currentLCM == k {
				count++
			}
		}
	}
	return count
}
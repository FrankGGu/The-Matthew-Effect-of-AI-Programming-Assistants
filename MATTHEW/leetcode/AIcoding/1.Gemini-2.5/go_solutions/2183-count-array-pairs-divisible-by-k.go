package main

import "math"

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func countPairs(nums []int, k int) int64 {
	var ans int64 = 0

	// freqDivisors[d] stores the count of numbers encountered so far (nums[j] for j < i)
	// that are multiples of d.
	// The maximum value for nums[i] and k is 10^5.
	// requiredMultiple = k / gcd(num, k) will be at most k.
	// Divisors 'd' of 'num' can be at most 'num'.
	// So, the array needs to be sized up to max(max(nums), k) + 1.
	// Since both max(nums) and k are 10^5, 100001 is the correct size.
	freqDivisors := make([]int, 100001)

	for _, num := range nums {
		// Calculate the required factor for previous numbers (nums[j] where j < i).
		// For (num * nums[j]) % k == 0, it must be that nums[j] is a multiple of (k / gcd(num, k)).
		g := gcd(num, k)
		requiredMultiple := k / g

		// Add to ans the count of numbers seen so far that are multiples of requiredMultiple.
		// These are the nums[j] values (j < i) that form a valid pair with the current 'num'.
		if requiredMultiple < len(freqDivisors) { // Check to prevent out-of-bounds, though requiredMultiple <= k <= 100000, so it's always valid.
			ans += int64(freqDivisors[requiredMultiple])
		}

		// Update freqDivisors for the current 'num'.
		// For each divisor 'd' of 'num', increment freqDivisors[d].
		// This indicates that 'num' is a multiple of 'd'.
		sqrtNum := int(math.Sqrt(float64(num)))
		for d := 1; d <= sqrtNum; d++ {
			if num%d == 0 {
				// d is a divisor
				freqDivisors[d]++

				// num/d is also a divisor, if it's different from d
				if d*d != num {
					freqDivisors[num/d]++
				}
			}
		}
	}

	return ans
}
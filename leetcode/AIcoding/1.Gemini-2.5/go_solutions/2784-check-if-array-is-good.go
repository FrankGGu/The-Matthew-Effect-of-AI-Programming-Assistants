package main

func isGood(nums []int) bool {
	n := len(nums)

	// A good array of length n must contain integers from 1 to n-1 once,
	// and the integer n-1 exactly twice.
	// This implies that the array must have at least two elements (for n-1 to appear twice).
	// If n is 1, n-1 is 0, which cannot be in nums[i] >= 1.
	// Also, if n-1 appears twice, the total length must be at least 2.
	// If n = 1, the definition of "good" doesn't really apply or makes it impossible.
	// For example, if n=1, expected values are 1 to 0 (empty set) and 0 twice. Impossible.
	// The constraints state 1 <= nums[i] <= nums.length.
	// If nums.length is 1, nums=[1]. My logic below should correctly return false.

	// freq[i] will store the count of value i+1.
	// So, freq[0] for value 1, freq[1] for value 2, ..., freq[n-2] for value n-1.
	// The size of freq needs to be n to cover values up to n.
	// However, valid numbers for a good array are only 1 to n-1.
	// If any number is outside this range, it's not good.
	freq := make([]int, n) // freq[idx] counts value (idx + 1)

	for _, num := range nums {
		// All numbers in a good array must be between 1 and n-1 (inclusive).
		// If num is less than 1 or greater than n-1, it cannot be a good array.
		// (e.g., if num == n, it's an invalid value for a good array of length n).
		if num < 1 || num > n-1 {
			return false
		}
		freq[num-1]++
	}

	// Check counts for values 1 to n-2. Each should appear exactly once.
	// These correspond to indices 0 to n-3 in the freq array.
	for i := 0; i < n-2; i++ {
		if freq[i] != 1 {
			return false
		}
	}

	// Check count for value n-1. It should appear exactly twice.
	// This corresponds to index n-2 in the freq array.
	// This check also covers the edge case where n=1 (n-2 = -1, this index would be out of bounds,
	// but the loop for i < n-2 would not run, and freq[-1] would cause a panic if not for the num > n-1 check).
	// For n=1, n-1=0. The check `num > n-1` (1 > 0) would return false earlier.
	// For n=2, n-2=0. This checks freq[0].
	if freq[n-2] != 2 {
		return false
	}

	return true
}
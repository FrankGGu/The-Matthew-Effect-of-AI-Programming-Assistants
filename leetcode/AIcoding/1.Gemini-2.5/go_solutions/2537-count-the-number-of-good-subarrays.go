package main

import "fmt"

func countGoodSubarrays(nums []int, k int64) int64 {
	var ans int64 = 0
	left := 0
	var currentPairs int64 = 0
	freq := make(map[int]int64) // Use int64 for frequencies to avoid overflow in pair calculation

	n := len(nums)

	for right := 0; right < n; right++ {
		valR := nums[right]

		// When adding nums[right], the number of new pairs it forms is its current frequency.
		// For example, if valR appears 'f' times, adding another valR makes it 'f+1' times.
		// The number of pairs increases by 'f'.
		currentPairs += freq[valR]
		freq[valR]++

		// While the current window [left...right] has at least k pairs:
		// All subarrays starting from `left` up to `right` (i.e., [left...right], [left...right+1], ..., [left...n-1])
		// are good. The number of such subarrays is (n - right).
		// This is because adding elements to the right can only increase or keep the number of pairs the same.
		// So if [left...right] is good, then [left...right+1], [left...right+2], ..., [left...n-1] are also good.
		// We add (n - right) to the total count.
		// Then, we try to shrink the window from the left to find more good subarrays.
		for currentPairs >= k {
			ans += int64(n - right)

			valL := nums[left]

			// When removing nums[left], the number of pairs decreases by (freq[valL] - 1).
			// This is because valL was forming pairs with (freq[valL] - 1) other instances of itself.
			// After removing one, it forms pairs with (freq[valL] - 2) instances.
			// The decrease is (freq[valL] - 1).
			freq[valL]--
			currentPairs -= freq[valL] // freq[valL] is now the new, decreased frequency

			left++
		}
	}

	return ans
}
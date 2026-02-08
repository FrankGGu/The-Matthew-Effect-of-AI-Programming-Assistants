import (
	"math"
)

func maximumSubarraySum(nums []int, k int) int64 {
	n := len(nums)

	// minPrefixSum[r] stores the minimum prefix sum P_j such that the length of the prefix 'j'
	// (i.e., sum of nums[0...j-1]) has a remainder 'r' when divided by k (j % k == r).
	// We want to maximize P_current - P_prev where (current_length - prev_length) is divisible by k.
	// This implies current_length % k == prev_length % k.
	// 'current_length' corresponds to (idx + 1) in the loop (length of nums[0...idx]).
	// 'prev_length' corresponds to 'j'.
	minPrefixSum := make([]int64, k)
	for i := 0; i < k; i++ {
		minPrefixSum[i] = math.MaxInt64
	}

	// Initialize minPrefixSum[0] to 0. This represents an empty prefix (length 0, sum 0).
	// Length 0 is divisible by any k, allowing subarrays starting from index 0 to be considered.
	minPrefixSum[0] = 0

	var currentPrefixSum int64 = 0
	// Initialize maxSum to 0. An empty subarray has sum 0 and length 0, which is divisible by k.
	// This handles cases where all valid non-empty subarrays have negative sums,
	// or no non-empty subarrays meet the length condition (e.g., n < k).
	var maxSum int64 = 0 

	for idx := 0; idx < n; idx++ {
		currentPrefixSum += int64(nums[idx])

		// The length of the current prefix (nums[0...idx]) is (idx + 1).
		currentLengthModK := (idx + 1) % k

		// If we have previously encountered a prefix sum P_j with length 'j'
		// such that j % k == currentLengthModK, then the subarray from 'j' to 'idx'
		// has length (idx + 1) - j, which is divisible by k.
		if minPrefixSum[currentLengthModK] != math.MaxInt64 {
			// Calculate the sum of this subarray: currentPrefixSum - minPrefixSum[currentLengthModK]
			// Update maxSum if this is greater.
			if currentPrefixSum-minPrefixSum[currentLengthModK] > maxSum {
				maxSum = currentPrefixSum - minPrefixSum[currentLengthModK]
			}
		}

		// Update the minimum prefix sum encountered so far for the current remainder.
		// This update must happen AFTER calculating maxSum for the current prefix sum,
		// to ensure that we are always using a *previous* prefix sum to form a subarray.
		if currentPrefixSum < minPrefixSum[currentLengthModK] {
			minPrefixSum[currentLengthModK] = currentPrefixSum
		}
	}

	return maxSum
}
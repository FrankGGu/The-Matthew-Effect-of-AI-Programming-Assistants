package main

import "fmt"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minOperations(nums []int, k int) int {
	n := len(nums)

	var totalSum int64
	for _, num := range nums {
		totalSum += int64(num)
	}

	targetRemainder := int(totalSum % int64(k))

	if targetRemainder == 0 {
		return 0
	}

	remainderToIndex := make(map[int]int)
	remainderToIndex[0] = -1 // Represents an empty prefix sum (0) before index -1

	var currentPrefixSum int64
	minLen := n // Initialize minLen to n (maximum possible length)

	for i := 0; i < n; i++ {
		currentPrefixSum += int64(nums[i])
		currentRem := int(currentPrefixSum % int64(k))

		// We are looking for a previous prefix sum remainder `neededRem` such that
		// (currentPrefixSum - prefixSum_at_neededRem_index) % k == targetRemainder
		// This translates to:
		// (currentRem - neededRem + k) % k == targetRemainder
		// Rearranging for neededRem:
		// neededRem = (currentRem - targetRemainder + k) % k
		neededRem := (currentRem - targetRemainder + k) % k

		if prevIdx, ok := remainderToIndex[neededRem]; ok {
			// If `neededRem` was found, it means the subarray from `prevIdx + 1` to `i`
			// has a sum whose remainder modulo k is `targetRemainder`.
			minLen = min(minLen, i-prevIdx)
		}

		// Store or update the current remainder and its index.
		// We always store the latest index for a given remainder to find the shortest subarray.
		remainderToIndex[currentRem] = i
	}

	// If minLen is still n, it means no valid subarray (smaller than the whole array)
	// was found whose removal would make the sum divisible by k.
	// If targetRemainder was 0, we would have returned 0 already.
	// So, if targetRemainder != 0 and minLen == n, it implies it's impossible
	// to achieve the goal by removing a proper subarray.
	if minLen == n {
		return -1
	}

	return minLen
}
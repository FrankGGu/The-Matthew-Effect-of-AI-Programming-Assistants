package main

import "math"

func minSubarray(nums []int, p int) int {
	n := len(nums)

	// Calculate the total sum modulo p
	// This will be the target remainder for the subarray sum
	totalSumModP := 0
	for _, num := range nums {
		totalSumModP = (totalSumModP + num) % p
	}

	// If the total sum is already divisible by p, no removal is needed.
	if totalSumModP == 0 {
		return 0
	}

	// Initialize minLen to n (maximum possible length, indicating no valid subarray found yet)
	minLen := n

	// remainderMap stores (prefixSum_mod_p, index)
	// We add 0: -1 to handle subarrays that start from index 0
	remainderMap := make(map[int]int)
	remainderMap[0] = -1 

	currentPrefixSumModP := 0
	for i := 0; i < n; i++ {
		// Update current prefix sum modulo p
		currentPrefixSumModP = (currentPrefixSumModP + nums[i]) % p

		// We are looking for a subarray (from index prevIndex+1 to i)
		// whose sum modulo p is equal to totalSumModP.
		// Let currentPrefixSum be S_i and previousPrefixSum be S_j.
		// We want (S_i - S_j) % p == totalSumModP.
		// This means (S_i % p - S_j % p + p) % p == totalSumModP.
		// So, S_j % p should be (S_i % p - totalSumModP + p) % p.
		neededPreviousPrefixSumModP := (currentPrefixSumModP - totalSumModP + p) % p

		if prevIndex, ok := remainderMap[neededPreviousPrefixSumModP]; ok {
			// If we found a matching previous prefix sum, calculate the length of this subarray
			currentSubarrayLength := i - prevIndex
			minLen = int(math.Min(float64(minLen), float64(currentSubarrayLength)))
		}

		// Store the current prefix sum modulo p and its index
		// If a remainder already exists, update its index to the latest one
		// because we want the smallest subarray, and a later index allows for a shorter subarray.
		remainderMap[currentPrefixSumModP] = i
	}

	// If minLen is still n, it means no proper subarray was found that satisfies the condition.
	// Removing the entire array is not considered a valid removal for this problem's "smallest subarray" context.
	if minLen == n {
		return -1
	}

	return minLen
}
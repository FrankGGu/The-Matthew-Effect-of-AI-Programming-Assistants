package main

import (
	"math"
)

func minimumArrayChanges(nums []int, limit int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	minChanges := n

	// Case 1: N > limit.
	// In this case, (limit-1)/(N-1) < 1.
	// So, the only possible integer common difference K such that A + i*K remains within [1, limit] for all i
	// is K = 0.
	// If K = 0, the array becomes [A, A, ..., A].
	// We need to find the A that minimizes changes. This means A should be the most frequent element in nums.
	if n > limit {
		freq := make(map[int]int)
		maxFreq := 0
		for _, num := range nums {
			freq[num]++
			if freq[num] > maxFreq {
				maxFreq = freq[num]
			}
		}
		return n - maxFreq
	}

	// Case 2: N <= limit.
	// The maximum absolute value for K is (limit-1)/(N-1).
	// If K is larger than this, A + (N-1)*K or A + 0*K will fall out of bounds [1, limit]
	// for any A in [1, limit].
	maxAbsK := (limit - 1) / (n - 1)

	// Iterate through possible common differences K.
	// K can range from -maxAbsK to maxAbsK.
	for k := -maxAbsK; k <= maxAbsK; k++ {
		// Calculate the valid range for the starting value A (nums[0]) for the current K.
		// A must satisfy 1 <= A + i*K <= limit for all i in [0, N-1].
		// This implies:
		// 1 - i*K <= A <= limit - i*K
		// So, A_min = max(1, max_{i in [0,N-1]}(1 - i*K))
		// And, A_max = min(limit, min_{i in [0,N-1]}(limit - i*K))
		currentAMin := 1
		currentAMax := limit

		for i := 0; i < n; i++ {
			currentAMin = max(currentAMin, 1-i*k)
			currentAMax = min(currentAMax, limit-i*k)
		}

		// If the valid range for A is empty, this K is impossible.
		if currentAMin > currentAMax {
			continue
		}

		// For the current K, we want to find an A in [currentAMin, currentAMax]
		// that maximizes the number of elements nums[i] such that nums[i] == A + i*K.
		// This is equivalent to maximizing the frequency of (nums[i] - i*K) within the range [currentAMin, currentAMax].
		freqMap := make(map[int]int)
		maxFreqForK := 0

		for i := 0; i < n; i++ {
			candidateA := nums[i] - i*k
			if candidateA >= currentAMin && candidateA <= currentAMax {
				freqMap[candidateA]++
				if freqMap[candidateA] > maxFreqForK {
					maxFreqForK = freqMap[candidateA]
				}
			}
		}

		// The number of changes for this K is N - maxFreqForK.
		// Update the overall minimum changes.
		minChanges = min(minChanges, n-maxFreqForK)
	}

	return minChanges
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
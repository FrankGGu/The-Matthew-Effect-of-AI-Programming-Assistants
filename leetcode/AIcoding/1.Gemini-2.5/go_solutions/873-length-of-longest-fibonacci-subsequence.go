package main

func lenLongestFibSubseq(arr []int) int {
	n := len(arr)
	valToIndex := make(map[int]int, n)
	for i, num := range arr {
		valToIndex[num] = i
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = 2 // Initialize with length 2 for the pair (arr[i], arr[j])
		}
	}

	maxLen := 0

	for j := 0; j < n; j++ {
		for i := 0; i < j; i++ {
			// We are looking for a previous element `prevVal` such that `prevVal + arr[i] = arr[j]`
			// So, `prevVal = arr[j] - arr[i]`
			prevVal := arr[j] - arr[i]

			// For `prevVal, arr[i], arr[j]` to form a valid Fibonacci subsequence:
			// 1. `prevVal` must be strictly less than `arr[i]` (to ensure `k < i` since `arr` is strictly increasing).
			// 2. `prevVal` must exist in the input array `arr`.
			if prevVal < arr[i] {
				if k, found := valToIndex[prevVal]; found {
					// If `prevVal` is found at index `k`, then the length of the Fibonacci subsequence
					// ending with `arr[i]` and `arr[j]` is `dp[k][i] + 1`.
					dp[i][j] = dp[k][i] + 1
				}
			}

			// Update the overall maximum length found so far.
			if dp[i][j] > maxLen {
				maxLen = dp[i][j]
			}
		}
	}

	// A Fibonacci subsequence must have at least 3 elements.
	// If `maxLen` is less than 3, it means no such subsequence was found.
	if maxLen < 3 {
		return 0
	}
	return maxLen
}
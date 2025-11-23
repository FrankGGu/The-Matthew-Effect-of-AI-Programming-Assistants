package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func waysToPartition(nums []int, k int) int {
	n := len(nums)

	prefixSums := make([]int, n+1)
	currentSum := 0
	for j := 0; j < n; j++ {
		currentSum += nums[j]
		prefixSums[j+1] = currentSum
	}
	totalSum := prefixSums[n]

	maxWays := 0

	if totalSum%2 == 0 {
		target := totalSum / 2
		count := 0
		for p := 1; p < n; p++ { // Partition point p from 1 to n-1
			if prefixSums[p] == target {
				count++
			}
		}
		maxWays = count
	}

	leftFreq := make(map[int]int)  // Stores counts of P[p] for 1 <= p <= i
	rightFreq := make(map[int]int) // Stores counts of P[p] for i+1 <= p <= n-1

	// Initialize rightFreq with all possible partition prefix sums P[1]...P[n-1]
	for p := 1; p < n; p++ {
		rightFreq[prefixSums[p]]++
	}

	for i := 0; i < n; i++ { // i is the index of the element being changed (nums[i] to k)
		oldVal := nums[i]

		// P[i+1] (sum of nums[0...i]) is moving from the "right" side to the "left" side.
		// If P[i+1] is a valid partition point (i.e., i+1 < n), decrement its count in rightFreq.
		if i+1 < n {
			rightFreq[prefixSums[i+1]]--
			if rightFreq[prefixSums[i+1]] == 0 {
				delete(rightFreq, prefixSums[i+1])
			}
		}

		newTotalSum := totalSum - oldVal + k
		currentWays := 0

		if newTotalSum%2 == 0 {
			targetHalfSum := newTotalSum / 2

			// Case 1: Partition point p such that 1 <= p <= i.
			// The prefix sum P[p] uses original values.
			// We need P[p] == targetHalfSum.
			currentWays += leftFreq[targetHalfSum]

			// Case 2: Partition point p such that i+1 <= p <= n-1.
			// The prefix sum P[p] has nums[i] replaced by k.
			// P[p]_modified = P[p]_original - oldVal + k.
			// We need P[p]_modified == targetHalfSum.
			// So, P[p]_original == targetHalfSum + oldVal - k.
			currentWays += rightFreq[targetHalfSum+oldVal-k]
		}

		maxWays = max(maxWays, currentWays)

		// After processing for current `i`, P[i+1] is now considered part of the "left" side for the next iteration.
		// If P[i+1] is a valid partition point (i.e., i+1 < n), increment its count in leftFreq.
		if i+1 < n {
			leftFreq[prefixSums[i+1]]++
		}
	}

	return maxWays
}
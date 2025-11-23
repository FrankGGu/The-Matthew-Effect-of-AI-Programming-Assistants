import "math"

func minMoves(nums []int, k int) int64 {
	onesPos := []int{}
	for i, num := range nums {
		if num == 1 {
			onesPos = append(onesPos, i)
		}
	}

	nOnes := len(onesPos)
	if nOnes < k {
		return 0 // Should not happen based on problem constraints/intent
	}

	// Calculate diff[j] = onesPos[j] - j
	// This transforms the problem from making k ones at positions pos[i], ..., pos[i+k-1]
	// to become X, X+1, ..., X+k-1
	// to making k values diff[i], ..., diff[i+k-1]
	// to become Y, Y, ..., Y (where Y is the median of diff values)
	diff := make([]int, nOnes)
	for i := 0; i < nOnes; i++ {
		diff[i] = onesPos[i] - i
	}

	// Calculate prefix sums for diff array
	prefixSumDiff := make([]int64, nOnes+1)
	for i := 0; i < nOnes; i++ {
		prefixSumDiff[i+1] = prefixSumDiff[i] + int64(diff[i])
	}

	minCost := int64(math.MaxInt64)

	// Sliding window of size k over the diff array
	// m is the index of the median element within the current window [i...i+k-1]
	// For 0-indexed array, median is at index k/2.
	m := k / 2

	for i := 0; i <= nOnes-k; i++ {
		// The median element in the current window diff[i...i+k-1] is diff[i+m]
		medianVal := int64(diff[i+m])

		// Sum of elements to the left of median (exclusive)
		// diff[i] ... diff[i+m-1]
		leftSum := prefixSumDiff[i+m] - prefixSumDiff[i]

		// Sum of elements to the right of median (exclusive)
		// diff[i+m+1] ... diff[i+k-1]
		rightSum := prefixSumDiff[i+k] - prefixSumDiff[i+m+1]

		var currentCost int64
		if k%2 == 1 { // k is odd
			// Cost = sum(|diff[j] - medianVal|)
			// = sum_{j=0}^{m-1} (medianVal - diff[i+j]) + sum_{j=m+1}^{k-1} (diff[i+j] - medianVal)
			// = m * medianVal - leftSum + rightSum - (k-1-m) * medianVal
			// = medianVal * (m - (k-1-m)) - leftSum + rightSum
			// For odd k, m = (k-1)/2, so m - (k-1-m) = m - (2m+1-1-m) = m - (m) = 0
			currentCost = rightSum - leftSum
		} else { // k is even
			// Cost = sum(|diff[j] - medianVal|)
			// = sum_{j=0}^{m-1} (medianVal - diff[i+j]) + sum_{j=m+1}^{k-1} (diff[i+j] - medianVal)
			// = medianVal * (m - (k-1-m)) - leftSum + rightSum
			// For even k, m = k/2, so m - (k-1-m) = m - (2m-1-m) = m - (m-1) = 1
			currentCost = medianVal - leftSum + rightSum
		}

		if currentCost < minCost {
			minCost = currentCost
		}
	}

	return minCost
}
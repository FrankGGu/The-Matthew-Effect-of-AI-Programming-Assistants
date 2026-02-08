import "sort"

func incremovableSubarrayCount(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// L: length of the longest strictly increasing prefix nums[0...L-1]
	// nums[0...L-1] is strictly increasing
	// L can be from 0 to n
	L := 0
	if n > 0 {
		L = 1
		for k := 1; k < n; k++ {
			if nums[k-1] < nums[k] {
				L = k + 1
			} else {
				break
			}
		}
	}

	// R: start index of the longest strictly increasing suffix nums[R...n-1]
	// nums[R...n-1] is strictly increasing
	// R can be from 0 to n
	R := n
	if n > 0 {
		R = n - 1
		for k := n - 2; k >= 0; k-- {
			if nums[k] < nums[k+1] {
				R = k
			} else {
				break
			}
		}
	}

	ans := 0

	// Iterate i from 0 to L (inclusive)
	// i represents the length of the prefix nums[0...i-1]
	// If i=0, prefix is empty. If i=L, prefix is nums[0...L-1].
	for i := 0; i <= L; i++ {
		// j represents the end index of the subarray to remove.
		// The remaining suffix starts at j+1.
		// We need j+1 >= R for nums[j+1...n-1] to be strictly increasing.
		// So j >= R-1.
		// Also, the subarray to remove is nums[i...j], so i <= j.
		// Thus, j must be at least max(i, R-1).
		jStart := max(i, R-1)

		// If jStart is already beyond the array bounds, no valid j exists for this i.
		if jStart >= n {
			continue
		}

		currentAnsForI := 0

		// Case 1: i == 0 (empty prefix remaining)
		// No cross-condition nums[i-1] < nums[j+1] applies.
		// We just need j >= jStart and j < n.
		if i == 0 {
			currentAnsForI = (n - 1) - jStart + 1
		} else {
			// Case 2: i > 0 (non-empty prefix remaining)
			// We need nums[i-1] < nums[j+1] for j < n-1.
			// For j = n-1, there is no suffix, so the cross-condition is not applicable.
			// This case (j=n-1) is always valid if j=n-1 is within the allowed range [jStart, n-1].

			valIMinus1 := nums[i-1]

			// Count j in [jStart, n-2] such that nums[i-1] < nums[j+1].
			// This means j+1 must be in [jStart+1, n-1].
			// Also, j+1 must be >= R.
			// So k = j+1 must be in [max(jStart+1, R), n-1].
			lowerBoundK := max(jStart+1, R)

			if lowerBoundK <= n-1 {
				// Search for the first index k in nums[lowerBoundK...n-1] such that nums[k] > valIMinus1.
				// The slice nums[lowerBoundK:n] is strictly increasing, so sort.SearchInts can be used.
				// We search for valIMinus1 + 1 to find elements strictly greater than valIMinus1.
				idxInSuffix := sort.SearchInts(nums[lowerBoundK:n], valIMinus1+1)

				// actualIdx is the absolute index in original nums array.
				actualIdx := lowerBoundK + idxInSuffix

				if actualIdx <= n-1 { // If such elements exist
					currentAnsForI += (n - 1) - actualIdx + 1
				}
			}

			// Add 1 for the case where j = n-1 (removed subarray is nums[i...n-1]).
			// This is valid if n-1 is within the range [jStart, n-1].
			if n-1 >= jStart {
				currentAnsForI += 1
			}
		}
		ans += currentAnsForI
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
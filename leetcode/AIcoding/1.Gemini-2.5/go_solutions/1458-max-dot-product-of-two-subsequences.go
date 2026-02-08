import "math"

func maxDotProduct(nums1 []int, nums2 []int) int {
	n1 := len(nums1)
	n2 := len(nums2)

	// dp[i][j] stores the maximum dot product using subsequences from nums1[0...i-1] and nums2[0...j-1].
	// The subsequences must be non-empty.
	// We initialize with math.MinInt32 to represent an invalid state or that no valid non-empty
	// subsequences have been formed yet for that subproblem.
	dp := make([][]int, n1+1)
	for i := range dp {
		dp[i] = make([]int, n2+1)
		for j := range dp[i] {
			dp[i][j] = math.MinInt32
		}
	}

	for i := 1; i <= n1; i++ {
		for j := 1; j <= n2; j++ {
			currentProduct := nums1[i-1] * nums2[j-1]

			// Case 1: The current elements nums1[i-1] and nums2[j-1] form the entire subsequences.
			// This ensures the non-empty constraint is always met for at least one path.
			dp[i][j] = currentProduct

			// Case 2: Extend previously formed subsequences with nums1[i-1] and nums2[j-1].
			// If dp[i-1][j-1] was math.MinInt32, adding currentProduct will still result in a
			// very small number, which will be correctly ignored by the max function in favor of Case 1.
			dp[i][j] = max(dp[i][j], dp[i-1][j-1]+currentProduct)

			// Case 3: Don't include nums1[i-1] in its subsequence.
			// The max dot product comes from nums1[0...i-2] and nums2[0...j-1].
			// If dp[i-1][j] is math.MinInt32, it means no valid subsequences could be formed
			// without nums1[i-1] up to this point, so it will be ignored by max.
			dp[i][j] = max(dp[i][j], dp[i-1][j])

			// Case 4: Don't include nums2[j-1] in its subsequence.
			// The max dot product comes from nums1[0...i-1] and nums2[0...j-2].
			// Similar to Case 3, math.MinInt32 will be ignored.
			dp[i][j] = max(dp[i][j], dp[i][j-1])
		}
	}

	return dp[n1][n2]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
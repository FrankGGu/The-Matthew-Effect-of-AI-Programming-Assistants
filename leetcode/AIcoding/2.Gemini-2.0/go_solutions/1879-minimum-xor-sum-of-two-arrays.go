import "math"

func minimumXORSum(nums1 []int, nums2 []int) int {
	n := len(nums1)
	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for mask := 0; mask < (1 << n); mask++ {
		count := 0
		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				count++
			}
		}
		if count == n {
			continue
		}

		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 0 {
				newMask := mask | (1 << i)
				dp[newMask] = min(dp[newMask], dp[mask]+(nums1[count]^nums2[i]))
			}
		}
	}

	return dp[(1<<n)-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
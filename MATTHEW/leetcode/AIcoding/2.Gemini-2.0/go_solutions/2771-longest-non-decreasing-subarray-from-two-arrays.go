func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func longestNonDecreasingSubarray(nums1 []int, nums2 []int) int {
	n := len(nums1)
	ans := 1
	dp1 := 1
	dp2 := 1
	for i := 1; i < n; i++ {
		ndp1 := 1
		ndp2 := 1

		if nums1[i] >= nums1[i-1] {
			ndp1 = max(ndp1, dp1+1)
		}
		if nums1[i] >= nums2[i-1] {
			ndp1 = max(ndp1, dp2+1)
		}

		if nums2[i] >= nums1[i-1] {
			ndp2 = max(ndp2, dp1+1)
		}
		if nums2[i] >= nums2[i-1] {
			ndp2 = max(ndp2, dp2+1)
		}

		dp1 = ndp1
		dp2 = ndp2

		ans = max(ans, max(dp1, dp2))
	}

	return ans
}
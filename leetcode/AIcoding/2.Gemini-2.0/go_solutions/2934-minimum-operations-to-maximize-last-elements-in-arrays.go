func minOperations(nums1 []int, nums2 []int) int {
	n := len(nums1)
	ans := int(1e9)

	check := func(last1, last2 int) int {
		ops := 0
		for i := 0; i < n; i++ {
			if nums1[i] <= last1 && nums2[i] <= last2 {
				continue
			} else if nums1[i] <= last2 && nums2[i] <= last1 {
				ops++
			} else {
				return int(1e9)
			}
		}
		return ops
	}

	ans = min(ans, check(nums1[n-1], nums2[n-1]))
	nums1[n-1], nums2[n-1] = nums2[n-1], nums1[n-1]
	ans = min(ans, check(nums1[n-1], nums2[n-1])+1)

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
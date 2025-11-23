func longestNondecreasingSubarray(nums1 []int, nums2 []int) int {
	n := len(nums1)
	if n == 0 {
		return 0
	}

	max := func(a, b int) int {
		if a > b {
			return a
		}
		return b
	}

	prev0 := 1 // Max length ending at i-1 using nums1[i-1]
	prev1 := 1 // Max length ending at i-1 using nums2[i-1]
	maxLen := 1

	for i := 1; i < n; i++ {
		curr0 := 1 // Max length ending at i using nums1[i]
		curr1 := 1 // Max length ending at i using nums2[i]

		// Calculate curr0
		if nums1[i] >= nums1[i-1] {
			curr0 = max(curr0, prev0+1)
		}
		if nums1[i] >= nums2[i-1] {
			curr0 = max(curr0, prev1+1)
		}

		// Calculate curr1
		if nums2[i] >= nums1[i-1] {
			curr1 = max(curr1, prev0+1)
		}
		if nums2[i] >= nums2[i-1] {
			curr1 = max(curr1, prev1+1)
		}

		maxLen = max(maxLen, curr0)
		maxLen = max(maxLen, curr1)

		prev0 = curr0
		prev1 = curr1
	}

	return maxLen
}
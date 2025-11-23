func nextGreaterElement(nums1 []int, nums2 []int) []int {
	n1 := len(nums1)
	n2 := len(nums2)
	result := make([]int, n1)
	for i := 0; i < n1; i++ {
		result[i] = -1
	}

	for i := 0; i < n1; i++ {
		found := false
		for j := 0; j < n2; j++ {
			if nums2[j] == nums1[i] {
				found = true
			}
			if found && nums2[j] > nums1[i] {
				result[i] = nums2[j]
				break
			}
		}
	}

	return result
}
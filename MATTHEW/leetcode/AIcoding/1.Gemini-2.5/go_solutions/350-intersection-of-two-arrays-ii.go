func intersect(nums1 []int, nums2 []int) []int {
	if len(nums1) > len(nums2) {
		nums1, nums2 = nums2, nums1
	}

	freqMap := make(map[int]int)
	for _, num := range nums1 {
		freqMap[num]++
	}

	result := []int{}
	for _, num := range nums2 {
		if count, ok := freqMap[num]; ok && count > 0 {
			result = append(result, num)
			freqMap[num]--
		}
	}

	return result
}
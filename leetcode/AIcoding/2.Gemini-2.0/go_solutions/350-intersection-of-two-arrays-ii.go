func intersect(nums1 []int, nums2 []int) []int {
	m := make(map[int]int)
	for _, num := range nums1 {
		m[num]++
	}

	result := []int{}
	for _, num := range nums2 {
		if count, ok := m[num]; ok && count > 0 {
			result = append(result, num)
			m[num]--
		}
	}

	return result
}
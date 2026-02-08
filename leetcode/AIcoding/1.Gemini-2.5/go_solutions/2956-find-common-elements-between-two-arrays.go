func findCommonElements(nums1 []int, nums2 []int) []int {
	set1 := make(map[int]bool)
	for _, num := range nums1 {
		set1[num] = true
	}

	set2 := make(map[int]bool)
	for _, num := range nums2 {
		set2[num] = true
	}

	ans := make([]int, 2)

	for _, num := range nums1 {
		if set2[num] {
			ans[0]++
		}
	}

	for _, num := range nums2 {
		if set1[num] {
			ans[1]++
		}
	}

	return ans
}
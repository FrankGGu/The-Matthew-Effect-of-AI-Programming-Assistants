func twoOutOfThree(nums1 []int, nums2 []int, nums3 []int) []int {
	seen1 := make(map[int]bool)
	for _, num := range nums1 {
		seen1[num] = true
	}

	seen2 := make(map[int]bool)
	for _, num := range nums2 {
		seen2[num] = true
	}

	seen3 := make(map[int]bool)
	for _, num := range nums3 {
		seen3[num] = true
	}

	counts := make(map[int]int)

	for num := range seen1 {
		counts[num]++
	}

	for num := range seen2 {
		counts[num]++
	}

	for num := range seen3 {
		counts[num]++
	}

	var result []int
	for num, count := range counts {
		if count >= 2 {
			result = append(result, num)
		}
	}

	return result
}
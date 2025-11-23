func fourSumCount(nums1 []int, nums2 []int, nums3 []int, nums4 []int) int {
	count := 0
	sumMap := make(map[int]int)

	for _, a := range nums1 {
		for _, b := range nums2 {
			sumMap[a+b]++
		}
	}

	for _, c := range nums3 {
		for _, d := range nums4 {
			target := -(c + d)
			count += sumMap[target]
		}
	}

	return count
}
func maximumSetSize(nums1 []int, nums2 []int) int {
	n := len(nums1)
	set1 := make(map[int]bool)
	set2 := make(map[int]bool)
	for _, num := range nums1 {
		set1[num] = true
	}
	for _, num := range nums2 {
		set2[num] = true
	}

	only1 := 0
	only2 := 0
	common := 0

	for num := range set1 {
		if !set2[num] {
			only1++
		} else {
			common++
		}
	}

	for num := range set2 {
		if !set1[num] {
			only2++
		}
	}

	res := 0
	remove1 := 0
	remove2 := 0

	if only1 > n/2 {
		remove1 = only1 - n/2
	}
	if only2 > n/2 {
		remove2 = only2 - n/2
	}

	res = len(set1) + len(set2) - common - remove1 - remove2

	return res
}
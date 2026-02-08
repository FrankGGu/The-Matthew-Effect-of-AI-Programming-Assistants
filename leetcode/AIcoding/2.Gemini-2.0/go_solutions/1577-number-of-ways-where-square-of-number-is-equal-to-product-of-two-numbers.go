func numTriplets(nums1 []int, nums2 []int) int {
	count := 0
	count += countTriplets(nums1, nums2)
	count += countTriplets(nums2, nums1)
	return count
}

func countTriplets(nums1 []int, nums2 []int) int {
	count := 0
	m := make(map[int]int)
	for _, num := range nums2 {
		m[num]++
	}

	for _, a := range nums1 {
		square := a * a
		for i := 0; i < len(nums2); i++ {
			for j := i + 1; j < len(nums2); j++ {
				if nums2[i] * nums2[j] == square {
					count++
				}
			}
		}
	}
	return count
}
func minOperations(nums1 []int, nums2 []int) int {
	sum1 := 0
	for _, num := range nums1 {
		sum1 += num
	}

	sum2 := 0
	for _, num := range nums2 {
		sum2 += num
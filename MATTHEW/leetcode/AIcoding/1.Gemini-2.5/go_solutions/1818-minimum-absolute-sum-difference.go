func minAbsoluteSumDiff(nums1 []int, nums2 []int) int {
	n := len(nums1)

	// Create a sorted copy of nums1 to efficiently find the closest element
	sortedNums1 := make([]int, n)
	copy(sortedNums
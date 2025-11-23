func minSumSquareDiff(nums1 []int, nums2 []int, k1 int, k2 int) int64 {
	n := len(nums1)
	diffs := make([]int, n)
	maxDiff := 0
	for i := 0; i < n; i++ {
		diff := nums
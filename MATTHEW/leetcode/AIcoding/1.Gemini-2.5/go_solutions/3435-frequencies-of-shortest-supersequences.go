func shortestCommonSupersequence(nums1 []int, nums2 []int) int {
	n := len(nums1)
	m := len(nums2)
	mod := 1_000_000_007

	dpLen := make([][]int, n+1)
	dpCount := make([
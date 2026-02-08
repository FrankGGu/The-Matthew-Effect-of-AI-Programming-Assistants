func maxDistance(nums1 []int, nums2 []int) int {
	ans := 0
	i, j := 0, 0
	for i < len(nums1) && j < len(nums2) {
		if nums1[i] <= nums2[j] {
			ans = max(ans, j-i)
			j++
		} else {
			i++
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxSum(nums1 []int, nums2 []int) int {
	n1, n2 := len(nums1), len(nums2)
	i, j := 0, 0
	sum1, sum2 := 0, 0
	res := 0
	mod := 1000000007
	for i < n1 || j < n2 {
		if i < n1 && (j == n2 || nums1[i] < nums2[j]) {
			sum1 += nums1[i]
			i++
		} else if j < n2 && (i == n1 || nums2[j] < nums1[i]) {
			sum2 += nums2[j]
			j++
		} else {
			res += max(sum1, sum2) + nums1[i]
			res %= mod
			sum1, sum2 = 0, 0
			i++
			j++
		}
	}
	res += max(sum1, sum2)
	res %= mod
	return res
}
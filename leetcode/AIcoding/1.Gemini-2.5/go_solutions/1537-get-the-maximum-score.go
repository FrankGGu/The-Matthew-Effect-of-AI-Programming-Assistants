func maxSum(nums1 []int, nums2 []int) int {
	n1 := len(nums1)
	n2 := len(nums2)
	i, j := 0, 0
	var sum1, sum2 int64
	mod := int64(1e9 + 7)

	for i < n1 && j < n2 {
		if nums1[i] < nums2[j] {
			sum1 = (sum1 + int64(nums1[i])) % mod
			i++
		} else if nums2[j] < nums1[i] {
			sum2 = (sum2 + int64(nums2[j])) % mod
			j++
		} else { // nums1[i] == nums2[j]
			maxSumSoFar := sum1
			if sum2 > maxSumSoFar {
				maxSumSoFar = sum2
			}
			sum1 = (maxSumSoFar + int64(nums1[i])) % mod
			sum2 = (maxSumSoFar + int64(nums2[j])) % mod // nums1[i] == nums2[j], so this value is the same as sum1
			i++
			j++
		}
	}

	for i < n1 {
		sum1 = (sum1 + int64(nums1[i])) % mod
		i++
	}

	for j < n2 {
		sum2 = (sum2 + int64(nums2[j])) % mod
		j++
	}

	if sum1 > sum2 {
		return int(sum1)
	}
	return int(sum2)
}
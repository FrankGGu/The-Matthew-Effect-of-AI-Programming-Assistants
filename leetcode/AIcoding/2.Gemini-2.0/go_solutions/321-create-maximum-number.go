func maxNumber(nums1 []int, nums2 []int, k int) []int {
	n, m := len(nums1), len(nums2)
	res := make([]int, k)
	for i := max(0, k-m); i <= min(k, n); i++ {
		candidate := merge(maxArray(nums1, i), maxArray(nums2, k-i), k)
		if greater(candidate, 0, res, 0) {
			res = candidate
		}
	}
	return res
}

func maxArray(nums []int, k int) []int {
	n := len(nums)
	res := make([]int, k)
	j := 0
	for i := 0; i < n; i++ {
		for j > 0 && n-i+j > k && res[j-1] < nums[i] {
			j--
		}
		if j < k {
			res[j] = nums[i]
			j++
		}
	}
	return res
}

func merge(nums1 []int, nums2 []int, k int) []int {
	res := make([]int, k)
	i, j := 0, 0
	for r := 0; r < k; r++ {
		if greater(nums1, i, nums2, j) {
			res[r] = nums1[i]
			i++
		} else {
			res[r] = nums2[j]
			j++
		}
	}
	return res
}

func greater(nums1 []int, i int, nums2 []int, j int) bool {
	for i < len(nums1) && j < len(nums2) && nums1[i] == nums2[j] {
		i++
		j++
	}
	return j == len(nums2) || (i < len(nums1) && nums1[i] > nums2[j])
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
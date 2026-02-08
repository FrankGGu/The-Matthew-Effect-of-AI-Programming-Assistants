func numSubarrayProductLessThanK(nums []int, k int) int {
	if k <= 1 {
		return 0
	}
	left, prod, count := 0, 1, 0
	for right, num := range nums {
		prod *= num
		for prod >= k {
			prod /= nums[left]
			left++
		}
		count += right - left + 1
	}
	return count
}
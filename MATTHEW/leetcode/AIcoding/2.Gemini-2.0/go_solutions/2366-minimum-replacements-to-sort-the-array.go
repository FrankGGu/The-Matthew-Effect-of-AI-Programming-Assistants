func minimumReplacement(nums []int) int64 {
	n := len(nums)
	last := nums[n-1]
	ans := int64(0)
	for i := n - 2; i >= 0; i-- {
		if nums[i] > last {
			k := (nums[i] + last - 1) / last
			ans += int64(k - 1)
			last = nums[i] / k
		} else {
			last = nums[i]
		}
	}
	return ans
}
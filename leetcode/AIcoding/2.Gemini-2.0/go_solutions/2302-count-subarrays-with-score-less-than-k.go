func countSubarrays(nums []int, k int64) int64 {
	var count int64
	var sum int64
	left := 0
	for right := 0; right < len(nums); right++ {
		sum += int64(nums[right])
		for sum*int64(right-left+1) >= k && left <= right {
			sum -= int64(nums[left])
			left++
		}
		count += int64(right - left + 1)
	}
	return count
}
func countSubarrays(nums []int, k int64) int64 {
	var count int64 = 0
	var currentSum int64 = 0
	left := 0

	for right := 0; right < len(nums); right++ {
		currentSum += int64(nums[right])

		for currentSum*int64(right-left+1) >= k {
			currentSum -= int64(nums[left])
			left++
		}

		count += int64(right - left + 1)
	}

	return count
}
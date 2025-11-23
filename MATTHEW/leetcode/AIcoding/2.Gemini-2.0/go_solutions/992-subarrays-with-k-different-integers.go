func subarraysWithKDistinct(nums []int, k int) int {
	return atMostKDistinct(nums, k) - atMostKDistinct(nums, k-1)
}

func atMostKDistinct(nums []int, k int) int {
	left, right := 0, 0
	count := 0
	freq := make(map[int]int)
	distinct := 0

	for right < len(nums) {
		if freq[nums[right]] == 0 {
			distinct++
		}
		freq[nums[right]]++

		for distinct > k {
			freq[nums[left]]--
			if freq[nums[left]] == 0 {
				distinct--
			}
			left++
		}

		count += right - left + 1
		right++
	}

	return count
}
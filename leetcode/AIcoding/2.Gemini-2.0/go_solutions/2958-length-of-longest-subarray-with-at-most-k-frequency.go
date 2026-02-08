func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxFrequency(nums []int, k int) int {
	freq := make(map[int]int)
	left := 0
	maxLen := 0
	for right := 0; right < len(nums); right++ {
		freq[nums[right]]++
		for {
			count := 0
			for _, v := range freq {
				if v > k {
					count++
				}
			}
			if count > 0 {
				freq[nums[left]]--
				left++
			} else {
				break
			}
		}
		maxLen = max(maxLen, right-left+1)
	}
	return maxLen
}
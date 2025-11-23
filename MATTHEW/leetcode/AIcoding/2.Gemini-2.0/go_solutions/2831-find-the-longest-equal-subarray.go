func longestEqualSubarray(nums []int, k int) int {
	freq := make(map[int]int)
	l := 0
	maxLen := 0
	removed := 0
	for r := 0; r < len(nums); r++ {
		freq[nums[r]]++
		maxFreq := 0
		for _, f := range freq {
			if f > maxFreq {
				maxFreq = f
			}
		}
		removed = (r - l + 1) - maxFreq
		for removed > k {
			freq[nums[l]]--
			l++
			maxFreq = 0
			for _, f := range freq {
				if f > maxFreq {
					maxFreq = f
				}
			}
			removed = (r - l + 1) - maxFreq
		}
		if r-l+1 > maxLen {
			maxLen = r - l + 1
		}
	}
	return maxLen
}
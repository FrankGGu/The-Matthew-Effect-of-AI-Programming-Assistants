func longestSubsequence(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return n
	}

	maxLen := 1
	for i := 0; i < n; {
		j := i + 1
		if j < n && nums[j] > nums[i] {
			for j < n && nums[j] > nums[j-1] {
				j++
			}
		} else if j < n && nums[j] < nums[i] {
			for j < n && nums[j] < nums[j-1] {
				j++
			}
		} else {
			j = i + 1
		}
		maxLen = max(maxLen, j-i)
		i = j
	}

	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
func characterReplacement(s string, k int) int {
	n := len(s)
	maxLen := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			counts := make(map[byte]int)
			maxCount := 0
			for l := i; l <= j; l++ {
				counts[s[l]]++
				if counts[s[l]] > maxCount {
					maxCount = counts[s[l]]
				}
			}
			if j-i+1-maxCount <= k {
				if j-i+1 > maxLen {
					maxLen = j - i + 1
				}
			}
		}
	}
	return maxLen
}
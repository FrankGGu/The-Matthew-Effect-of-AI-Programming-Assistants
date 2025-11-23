func maxEqualFreq(nums []int) int {
	count := make(map[int]int)
	freq := make(map[int]int)
	var maxFreq int
	for _, num := range nums {
		count[num]++
		freq[count[num]]++
		if count[num] > 1 {
			freq[count[num]-1]--
		}
		maxFreq = max(maxFreq, count[num])
		if freq[maxFreq] == 1 && (maxFreq == 1 || freq[maxFreq-1] == 0) {
			return len(nums)
		}
		if maxFreq > 1 && freq[maxFreq] == 1 && freq[maxFreq-1] == 0 {
			return len(nums) - 1
		}
		if freq[1] == len(count) {
			return len(nums)
		}
	}
	return 0
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
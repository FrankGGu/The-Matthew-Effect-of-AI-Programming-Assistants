func maxEqualFreq(nums []int) int {
	freq := make(map[int]int)
	count := make(map[int]int)
	maxFreq := 0
	ans := 0

	for i, num := range nums {
		if freq[num] > 0 {
			count[freq[num]]--
			if count[freq[num]] == 0 {
				delete(count, freq[num])
			}
		}

		freq[num]++
		count[freq[num]]++
		maxFreq = max(maxFreq, freq[num])

		if len(count) == 1 {
			if maxFreq == 1 || count[maxFreq] == 1 {
				ans = i + 1
			}
		} else if len(count) == 2 {
			for f, c := range count {
				if f == 1 && c == 1 {
					ans = i + 1
					break
				}
				if c == 1 && f == maxFreq && count[f-1] > 0 {
					ans = i + 1
					break
				}
			}
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
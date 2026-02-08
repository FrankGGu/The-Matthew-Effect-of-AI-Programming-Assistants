func mostFrequentEven(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		if num%2 == 0 {
			counts[num]++
		}
	}

	maxFreq := 0
	result := -1
	for num, freq := range counts {
		if freq > maxFreq {
			maxFreq = freq
			result = num
		} else if freq == maxFreq && num < result {
			result = num
		}
	}

	return result
}
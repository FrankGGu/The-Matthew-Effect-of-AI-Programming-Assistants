func mostFrequent(nums []int, key int) int {
	freqMap := make(map[int]int)

	for i := 0; i < len(nums)-1; i++ {
		if nums[i] == key {
			freqMap[nums[i+1]]++
		}
	}

	maxFreq := 0
	result := 0

	for num, freq := range freqMap {
		if freq > maxFreq {
			maxFreq = freq
			result = num
		}
	}

	return result
}
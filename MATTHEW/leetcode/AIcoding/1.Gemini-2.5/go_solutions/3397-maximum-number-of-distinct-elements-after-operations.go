func maxDistinctElements(nums []int, k int) int {
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	// Initial distinct count
	distinctCount := len(freq
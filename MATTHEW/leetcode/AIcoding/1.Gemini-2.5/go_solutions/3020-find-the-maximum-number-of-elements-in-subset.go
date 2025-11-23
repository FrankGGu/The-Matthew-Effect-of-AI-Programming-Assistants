func maximumLength(nums []int) int {
	freq := make(map[int]int)
	for _, num := range nums {
		freq[num]++
	}

	maxLen := 1 // Minimum possible length is 1 for any
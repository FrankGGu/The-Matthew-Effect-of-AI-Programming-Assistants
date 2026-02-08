func countKDifference(nums []int, k int) int {
	count := 0
	freq := make(map[int]int)

	for _, num := range nums {
		// Check for num - k
		if val, ok := freq[num-k]; ok {
			count += val
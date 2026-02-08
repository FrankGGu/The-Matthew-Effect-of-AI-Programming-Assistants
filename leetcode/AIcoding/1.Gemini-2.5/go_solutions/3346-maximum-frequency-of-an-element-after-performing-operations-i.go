func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)

	left := 0
	currentSum := 0
	maxFreq := 0

	for right := 0; right < len(nums); right++ {
		currentSum += nums
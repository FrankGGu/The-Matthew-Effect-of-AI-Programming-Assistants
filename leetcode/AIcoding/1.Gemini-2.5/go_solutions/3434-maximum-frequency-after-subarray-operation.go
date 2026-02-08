func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)

	var left int
	var currentSum int64
	maxFreq := 0
	n := len(nums)

	for right := 0; right < n; right
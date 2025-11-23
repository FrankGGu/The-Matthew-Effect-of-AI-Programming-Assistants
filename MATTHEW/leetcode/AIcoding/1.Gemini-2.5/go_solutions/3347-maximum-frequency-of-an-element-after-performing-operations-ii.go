func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)

	var left int
	var currentSum int
	maxLength := 0

	for right := 0; right < len(nums); right++ {
		currentSum += nums[right]
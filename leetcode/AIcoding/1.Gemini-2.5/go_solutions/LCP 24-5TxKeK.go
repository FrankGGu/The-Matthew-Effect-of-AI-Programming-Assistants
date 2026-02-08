func numberGame(nums []int) []int {
	sort.Ints(nums)
	arr := make([]int, len(nums))
	for i := 0; i < len(nums); i += 2 {
		arr[i] = nums[i+1]
		arr[i+1] = nums[i]
	}
	return arr
}
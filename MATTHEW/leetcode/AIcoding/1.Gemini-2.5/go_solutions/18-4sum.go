func fourSum(nums []int, target int) [][]int {
	sort.Ints(nums)
	n := len(nums)
	result := [][]int{}

	if n < 4 {
		return result
	}

	for i := 0; i
func nextGreaterElement(nums []int) []int {
	n := len(nums)
	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}

	// s1 stores indices p such that nums[p
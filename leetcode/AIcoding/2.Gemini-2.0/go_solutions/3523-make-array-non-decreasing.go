func makeArrayNonDecreasing(nums []int) int {
	stack := []int{}
	count := 0
	for _, num := range nums {
		c := 0
		for len(stack) > 0 && stack[len(stack)-1] > num {
			stack = stack[:len(stack)-1]
			c++
		}
		if c > 0 {
			count += c - 1
			num = nums[len(nums)-1]
		}
		stack = append(stack, num)
	}
	return count
}
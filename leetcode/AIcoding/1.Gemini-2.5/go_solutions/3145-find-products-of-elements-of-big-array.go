func productExceptSelf(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	mod := 1_000_000_007

	result[0] = 1
	for i := 1; i < n; i++ {
		result[i] = (result[i-1] * nums[i-1]) % mod
	}

	rightProduct := 1
	for i := n - 1; i >= 0; i-- {
		result[i] = (result[i] * rightProduct) % mod
		rightProduct = (rightProduct * nums[i]) % mod
	}

	return result
}
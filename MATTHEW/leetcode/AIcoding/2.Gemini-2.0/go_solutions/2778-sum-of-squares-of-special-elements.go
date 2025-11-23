func sumOfSquares(nums []int) int {
	n := len(nums)
	sum := 0
	for i := 0; i < n; i++ {
		if (i+1)%1 == 0 && n%(i+1) == 0 {
			sum += nums[i] * nums[i]
		}
	}
	return sum
}
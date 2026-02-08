func maxRotateFunction(nums []int) int {
	sum := 0
	f := 0
	for i, num := range nums {
		sum += num
		f += i * num
	}
	maxF := f
	for i := 1; i < len(nums); i++ {
		f += sum - len(nums)*nums[len(nums)-i]
		if f > maxF {
			maxF = f
		}
	}
	return maxF
}
func findNonMinOrMax(nums []int) int {
	if len(nums) < 3 {
		return -1
	}

	a, b, c := nums[0], nums[1], nums[2]

	if (a > b && a < c) || (a < b && a > c) {
		return a
	} else if (b > a && b < c) || (b < a && b > c) {
		return b
	} else {
		return c
	}
}
func getDigitSum(n int) int {
	sum := 0
	if n == 0 {
		return 0
	}
	for n > 0 {
		sum += n % 10
		n /= 10
	}
	return sum
}

func smallestEqual(nums []int) int {
	for i := 0; i < len(nums); i++ {
		if getDigitSum(i) == nums[i] {
			return i
		}
	}
	return -1
}
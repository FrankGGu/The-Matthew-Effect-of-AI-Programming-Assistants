func separateDigits(nums []int) []int {
	result := []int{}
	for _, num := range nums {
		digits := []int{}
		for num > 0 {
			digits = append(digits, num%10)
			num /= 10
		}
		for i := len(digits) - 1; i >= 0; i-- {
			result = append(result, digits[i])
		}
	}
	return result
}
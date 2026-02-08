func findNumbers(nums []int) int {
	count := 0
	for _, num := range nums {
		if evenDigits(num) {
			count++
		}
	}
	return count
}

func evenDigits(num int) bool {
	digits := 0
	for num > 0 {
		num /= 10
		digits++
	}
	return digits%2 == 0
}
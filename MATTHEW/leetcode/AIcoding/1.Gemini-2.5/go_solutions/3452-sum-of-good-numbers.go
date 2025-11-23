func getSumOfDigits(num int) int {
	sum := 0
	for num > 0 {
		sum += num % 10
		num /= 10
	}
	return sum
}

func sumOfGoodNumbers(n int) int {
	// This solution assumes a "Good Number" is
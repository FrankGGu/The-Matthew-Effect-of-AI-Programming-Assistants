func countDigits(num int) int {
	count := 0
	temp := num
	for temp > 0 {
		digit := temp % 10
		if num%digit == 0 {
			count++
		}
		temp /= 10
	}
	return count
}
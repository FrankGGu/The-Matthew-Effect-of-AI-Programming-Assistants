func reverse(x int) int {
	var reversedNum int64 = 0

	for x != 0 {
		digit := x % 10
		reversedNum = reversedNum*10 + int64(digit)
		x /= 10
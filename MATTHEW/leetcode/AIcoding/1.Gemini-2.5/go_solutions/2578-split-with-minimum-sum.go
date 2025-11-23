func splitNum(num int) int {
	var digits []int
	for num > 0 {
		digits = append(digits, num%10)
		num /= 10
	}

	sort.Ints(digits)

	num1 := 0
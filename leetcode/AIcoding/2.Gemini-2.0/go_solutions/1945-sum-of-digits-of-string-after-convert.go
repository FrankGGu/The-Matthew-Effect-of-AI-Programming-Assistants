import "strconv"

func getLucky(s string, k int) int {
	sum := 0
	for _, char := range s {
		num := int(char - 'a' + 1)
		sum += digitSum(num)
	}

	for i := 1; i < k; i++ {
		sum = digitSum(sum)
	}

	return sum
}

func digitSum(n int) int {
	sum := 0
	str := strconv.Itoa(n)
	for _, char := range str {
		digit, _ := strconv.Atoi(string(char))
		sum += digit
	}
	return sum
}
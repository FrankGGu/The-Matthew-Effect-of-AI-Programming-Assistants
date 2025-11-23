func findNthDigit(n int) int {
	digit := 1
	count := 9
	for n > digit*count {
		n -= digit * count
		digit++
		count *= 10
	}
	num := 1
	for i := 1; i < digit; i++ {
		num *= 10
	}
	num += (n - 1) / digit
	index := (n - 1) % digit
	str := string(strconvItoa(num)[index])
	result, _ := strconvAtoi(str)
	return result
}

func strconvItoa(n int) string {
	if n == 0 {
		return "0"
	}
	s := ""
	for n > 0 {
		digit := n % 10
		s = string(rune('0'+digit)) + s
		n /= 10
	}
	return s
}

func strconvAtoi(s string) (int, error) {
	result := 0
	for _, r := range s {
		digit := int(r - '0')
		result = result*10 + digit
	}
	return result, nil
}
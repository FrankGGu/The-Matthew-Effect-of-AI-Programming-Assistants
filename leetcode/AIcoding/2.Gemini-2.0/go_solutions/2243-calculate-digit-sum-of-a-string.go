func digitSum(s string, k int) string {
	for len(s) > k {
		next := ""
		for i := 0; i < len(s); i += k {
			sum := 0
			end := i + k
			if end > len(s) {
				end = len(s)
			}
			for j := i; j < end; j++ {
				sum += int(s[j] - '0')
			}
			next += string(itoa(sum))
		}
		s = next
	}
	return s
}

func itoa(n int) string {
	if n == 0 {
		return "0"
	}
	res := ""
	for n > 0 {
		res = string(rune(n%10+'0')) + res
		n /= 10
	}
	return res
}
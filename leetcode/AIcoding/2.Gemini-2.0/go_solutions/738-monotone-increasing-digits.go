func monotoneIncreasingDigits(n int) int {
	s := []byte(string(strconv.Itoa(n)))
	l := len(s)
	flag := l
	for i := l - 1; i > 0; i-- {
		if s[i] < s[i-1] {
			s[i-1]--
			flag = i
		}
	}
	for i := flag; i < l; i++ {
		s[i] = '9'
	}
	res, _ := strconv.Atoi(string(s))
	return res
}
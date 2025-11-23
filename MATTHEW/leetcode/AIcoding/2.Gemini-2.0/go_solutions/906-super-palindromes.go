func superpalindromesInRange(left string, right string) int {
	l := toInt(left)
	r := toInt(right)
	count := 0
	for i := 1; i <= 100000; i++ {
		s := generatePalindrome(i, true)
		n := toInt(s)
		sq := n * n
		if sq >= l && sq <= r && isPalindrome(strconv.Itoa(sq)) {
			count++
		}
	}
	for i := 1; i <= 100000; i++ {
		s := generatePalindrome(i, false)
		n := toInt(s)
		sq := n * n
		if sq >= l && sq <= r && isPalindrome(strconv.Itoa(sq)) {
			count++
		}
	}
	return count
}

func generatePalindrome(n int, odd bool) string {
	s := strconv.Itoa(n)
	if odd {
		for i := len(s) - 2; i >= 0; i-- {
			s += string(s[i])
		}
	} else {
		for i := len(s) - 1; i >= 0; i-- {
			s += string(s[i])
		}
	}
	return s
}

func isPalindrome(s string) bool {
	for i := 0; i < len(s)/2; i++ {
		if s[i] != s[len(s)-i-1] {
			return false
		}
	}
	return true
}

func toInt(s string) int {
	res, _ := strconv.Atoi(s)
	return res
}

func toInt64(s string) int64 {
	res, _ := strconv.ParseInt(s, 10, 64)
	return res
}
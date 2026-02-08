func digitSum(s string, k int) string {
	for len(s) > k {
		newS := ""
		for i := 0; i < len(s); i += k {
			end := i + k
			if end > len(s) {
				end = len(s)
			}
			sub := s[i:end]
			sum := 0
			for _, r := range sub {
				sum += int(r - '0')
			}
			newS += string(Itoa(sum))
		}
		s = newS
	}
	return s
}

func Itoa(n int) []byte {
	if n == 0 {
		return []byte{'0'}
	}
	var res []byte
	for n > 0 {
		res = append([]byte{byte(n%10 + '0')}, res...)
		n /= 10
	}
	return res
}
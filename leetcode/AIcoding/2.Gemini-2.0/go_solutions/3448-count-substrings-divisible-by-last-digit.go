func countSubstringsDivisibleByLastDigit(s string) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := s[i : j+1]
			lastDigit := int(sub[len(sub)-1] - '0')
			num := 0
			for _, c := range sub {
				num = num*10 + int(c-'0')
			}
			if lastDigit != 0 && num%lastDigit == 0 {
				ans++
			} else if lastDigit == 0 && num == 0 {
				ans++
			}
		}
	}
	return ans
}
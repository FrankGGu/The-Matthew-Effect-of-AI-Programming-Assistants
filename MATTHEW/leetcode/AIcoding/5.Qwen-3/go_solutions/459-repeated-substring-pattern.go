package main

func repeatedSubstringPattern(s string) bool {
	n := len(s)
	for i := 1; i <= n/2; i++ {
		if n%i == 0 {
			sub := s[0:i]
			concat := ""
			for j := 0; j < n/i; j++ {
				concat += sub
			}
			if concat == s {
				return true
			}
		}
	}
	return false
}
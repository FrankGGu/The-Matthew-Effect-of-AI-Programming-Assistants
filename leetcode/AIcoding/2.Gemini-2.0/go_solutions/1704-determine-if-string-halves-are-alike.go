func halvesAreAlike(s string) bool {
	n := len(s)
	a := s[:n/2]
	b := s[n/2:]
	vowels := "aeiouAEIOU"
	countA := 0
	countB := 0
	for i := 0; i < n/2; i++ {
		for j := 0; j < len(vowels); j++ {
			if a[i] == vowels[j] {
				countA++
			}
			if b[i] == vowels[j] {
				countB++
			}
		}
	}
	return countA == countB
}
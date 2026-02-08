func permutationDifference(s1 string, s2 string) int {
	n1, n2 := len(s1), len(s2)
	if n1 > n2 {
		s1, s2 = s2, s1
		n1, n2 = n2, n1
	}

	count := 0
	for i := 0; i <= n2-n1; i++ {
		sub := s2[i : i+n1]
		if isPermutation(s1, sub) {
			count++
		}
	}
	return count
}

func isPermutation(s1 string, s2 string) bool {
	if len(s1) != len(s2) {
		return false
	}
	freq := make(map[rune]int)
	for _, c := range s1 {
		freq[c]++
	}
	for _, c := range s2 {
		freq[c]--
		if freq[c] < 0 {
			return false
		}
	}
	return true
}
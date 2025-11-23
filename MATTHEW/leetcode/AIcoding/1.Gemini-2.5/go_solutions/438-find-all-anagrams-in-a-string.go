func findAnagrams(s string, p string) []int {
	ns, np := len(s), len(p)
	if ns < np {
		return []int{}
	}

	pFreq := make([]int, 26)
	sFreq := make([]int, 26)

	for i := 0; i < np; i++ {
		pFreq[p[i]-'a']++
	}

	result := []int{}
	match := 0

	for i := 0; i < np; i++ {
		sFreq[s[i]-'a']++
	}

	for i := 0; i < 26; i++ {
		if sFreq[i] == pFreq[i] {
			match++
		}
	}

	if match == 26 {
		result = append(result, 0)
	}

	for i := np; i < ns; i++ {
		charLeaving := s[i-np] - 'a'
		charEntering := s[i] - 'a'

		if sFreq[charLeaving] == pFreq[charLeaving] {
			match--
		}
		sFreq[charLeaving]--
		if sFreq[charLeaving] == pFreq[charLeaving] {
			match++
		}

		if sFreq[charEntering] == pFreq[charEntering] {
			match--
		}
		sFreq[charEntering]++
		if sFreq[charEntering] == pFreq[charEntering] {
			match++
		}

		if match == 26 {
			result = append(result, i-np+1)
		}
	}

	return result
}
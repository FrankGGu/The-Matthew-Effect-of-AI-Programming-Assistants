func findAnagrams(s string, p string) []int {
	result := []int{}
	if len(p) > len(s) {
		return result
	}

	pFreq := make([]int, 26)
	sFreq := make([]int, 26)

	for i := 0; i < len(p); i++ {
		pFreq[p[i]-'a']++
	}

	left := 0
	match := 0

	for right := 0; right < len(s); right++ {
		charRight := s[right] - 'a'
		sFreq[charRight]++
		if sFreq[charRight] <= pFreq[charRight] {
			match++
		}

		if right-left+1 == len(p) {
			if match == len(p) {
				result = append(result, left)
			}

			charLeft := s[left] - 'a'
			if sFreq[charLeft] <= pFreq[charLeft] {
				match--
			}
			sFreq[charLeft]--
			left++
		}
	}

	return result
}
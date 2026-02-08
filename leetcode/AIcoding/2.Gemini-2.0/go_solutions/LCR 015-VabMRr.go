func findAnagrams(s string, p string) []int {
	n, m := len(s), len(p)
	if n < m {
		return []int{}
	}

	pCount := make([]int, 26)
	sCount := make([]int, 26)

	for i := 0; i < m; i++ {
		pCount[p[i]-'a']++
		sCount[s[i]-'a']++
	}

	result := []int{}
	if compare(pCount, sCount) {
		result = append(result, 0)
	}

	for i := m; i < n; i++ {
		sCount[s[i-m]-'a']--
		sCount[s[i]-'a']++
		if compare(pCount, sCount) {
			result = append(result, i-m+1)
		}
	}

	return result
}

func compare(a, b []int) bool {
	for i := 0; i < 26; i++ {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}
func wordSubsets(A []string, B []string) []string {
	maxFreq := make([]int, 26)
	for _, b := range B {
		freq := make([]int, 26)
		for _, char := range b {
			freq[char-'a']++
		}
		for i := 0; i < 26; i++ {
			if freq[i] > maxFreq[i] {
				maxFreq[i] = freq[i]
			}
		}
	}

	result := []string{}
	for _, a := range A {
		freq := make([]int, 26)
		for _, char := range a {
			freq[char-'a']++
		}
		isSubset := true
		for i := 0; i < 26; i++ {
			if freq[i] < maxFreq[i] {
				isSubset = false
				break
			}
		}
		if isSubset {
			result = append(result, a)
		}
	}
	return result
}
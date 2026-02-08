func countVowelSubstrings(word string, k int) int {
	n := len(word)
	ans := 0
	for i := 0; i < n; i++ {
		vowels := 0
		consonants := 0
		a, e, ii, o, u := 0, 0, 0, 0, 0
		for j := i; j < n; j++ {
			ch := word[j]
			if ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' {
				vowels++
				if ch == 'a' {
					a++
				} else if ch == 'e' {
					e++
				} else if ch == 'i' {
					ii++
				} else if ch == 'o' {
					o++
				} else {
					u++
				}
			} else {
				consonants++
			}

			if a > 0 && e > 0 && ii > 0 && o > 0 && u > 0 && consonants == k {
				ans++
			}
		}
	}
	return ans
}
func countVowelStrings(word string, k int) int {
	n := len(word)
	ans := 0
	for i := 0; i < n; i++ {
		vowelCount := 0
		consonantCount := 0
		vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
		hasAllVowels := map[byte]bool{'a': false, 'e': false, 'i': false, 'o': false, 'u': false}
		distinctVowels := 0
		for j := i; j < n; j++ {
			if vowels[word[j]] {
				if !hasAllVowels[word[j]] {
					hasAllVowels[word[j]] = true
					distinctVowels++
				}
				vowelCount++
			} else {
				consonantCount++
			}
			if distinctVowels == 5 && consonantCount >= k {
				ans++
			}
		}
	}
	return ans
}
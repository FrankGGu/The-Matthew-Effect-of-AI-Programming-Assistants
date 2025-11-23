func maxVowels(s string, k int) int {
	vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
	count := 0
	maxCount := 0
	for i := 0; i < k; i++ {
		if vowels[s[i]] {
			count++
		}
	}
	maxCount = count
	for i := k; i < len(s); i++ {
		if vowels[s[i]] {
			count++
		}
		if vowels[s[i-k]] {
			count--
		}
		if count > maxCount {
			maxCount = count
		}
	}
	return maxCount
}
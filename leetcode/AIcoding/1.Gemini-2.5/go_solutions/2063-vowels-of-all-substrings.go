func countVowels(word string) int64 {
	var totalVowelCount int64 = 0
	n := len(word)

	for i := 0; i < n; i++ {
		char := word[i]
		if char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u' {
			totalVowelCount += int64(i+1) * int64(n-i)
		}
	}

	return totalVowelCount
}
func countVowels(word string) int64 {
	n := len(word)
	var count int64
	for i := 0; i < n; i++ {
		if word[i] == 'a' || word[i] == 'e' || word[i] == 'i' || word[i] == 'o' || word[i] == 'u' {
			count += int64(i+1) * int64(n-i)
		}
	}
	return count
}
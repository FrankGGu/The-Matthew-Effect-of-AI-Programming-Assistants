func countSubstrings(s string, k int) int {
	n := len(s)
	count := 0
	for i := 0; i < n; i++ {
		freq := make(map[rune]int)
		maxFreq := 0
		for j := i; j < n; j++ {
			freqRune := rune(s[j])
			freq[freqRune]++
			if freq[freqRune] > maxFreq {
				maxFreq = freq[freqRune]
			}
			if j-i+1-maxFreq <= k {
				count++
			}
		}
	}
	return count
}
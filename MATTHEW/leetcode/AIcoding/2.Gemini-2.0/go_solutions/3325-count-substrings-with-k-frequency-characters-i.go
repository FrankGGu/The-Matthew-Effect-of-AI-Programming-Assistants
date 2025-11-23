func countKSubstrings(s string, k int) int {
	n := len(s)
	count := 0
	for i := 0; i < n; i++ {
		freq := make(map[rune]int)
		for j := i; j < n; j++ {
			freq[rune(s[j])]++
			freqK := 0
			for _, v := range freq {
				if v == k {
					freqK++
				}
			}
			if freqK > 0 {
				count++
			}
		}
	}
	return count
}
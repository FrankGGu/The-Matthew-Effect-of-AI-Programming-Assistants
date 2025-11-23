func equalFrequency(word1 string, word2 string) bool {
	freq1 := [26]int{}
	freq2 := [26]int{}

	for _, r := range word1 {
		freq1[r-'a']++
	}
	for _, r := range word2 {
		freq2[r-'a']++
	}

	countDistinct := func(freq [26]int) int {
		count := 0
		for i := 0; i < 26; i++ {
			if freq[i] > 0 {
				count++
			}
		}
		return count
	}

	for i := 0; i < 26; i++ { // Character to take from word1 (char 'a'+i)
		for j := 0; j < 26; j++ { // Character to take from word2 (char 'a'+j)
			// Must be able to take character i from word1
			if freq1[i] == 0 {
				continue
			}
			// Must be able to take character j from word2
			if freq2[j] == 0 {
				continue
			}

			// Simulate swap
			freq1[i]--
			freq1[j]++
			freq2[j]--
			freq2[i]++

			distinct1 := countDistinct(freq1)
			distinct2 := countDistinct(freq2)

			if distinct1 == distinct2 {
				return true
			}

			// Revert swap for next iteration
			freq1[i]++
			freq1[j]--
			freq2[j]++
			freq2[i]--
		}
	}

	return false
}
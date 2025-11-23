func countSubstringsWithKFrequency(s string, k int) int {
	ans := 0
	n := len(s)

	for numUniqueTarget := 1; numUniqueTarget <= 26; numUniqueTarget++ {
		freq := [26]int{}
		left := 0
		unique := 0   // Number of unique characters in current window
		atLeastK := 0 // Number of unique characters that appear at least k times

		for right := 0; right < n; right++ {
			charIdx := s[right] - 'a'

			// Expand window
			if freq[charIdx] == 0 {
				unique++
			}
			freq[charIdx]++
			if freq[charIdx] == k {
				atLeastK++
			}

			// Shrink window if too many unique characters
			for unique > numUniqueTarget {
				leftCharIdx := s[left] - 'a'
				if freq[leftCharIdx] == k {
					atLeastK--
				}
				freq[leftCharIdx]--
				if freq[leftCharIdx] == 0 {
					unique--
				}
				left++
			}

			// If current window satisfies conditions
			if unique == numUniqueTarget && atLeastK == numUniqueTarget {
				ans++
			}
		}
	}
	return ans
}
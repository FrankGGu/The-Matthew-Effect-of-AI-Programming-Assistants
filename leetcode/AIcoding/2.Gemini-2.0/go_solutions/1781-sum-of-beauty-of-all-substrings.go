func beautySum(s string) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		freq := make([]int, 26)
		for j := i; j < n; j++ {
			freq[s[j]-'a']++
			maxFreq := 0
			minFreq := n
			for k := 0; k < 26; k++ {
				if freq[k] > 0 {
					if freq[k] > maxFreq {
						maxFreq = freq[k]
					}
					if freq[k] < minFreq {
						minFreq = freq[k]
					}
				}
			}
			ans += maxFreq - minFreq
		}
	}
	return ans
}
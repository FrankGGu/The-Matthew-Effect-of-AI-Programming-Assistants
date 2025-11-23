func countSubstrings(s string, k int, letter byte, maxLetter int, minLetter int) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		count := 0
		for j := i; j < n; j++ {
			if s[j] == letter {
				count++
			}
			if count <= maxLetter && count >= minLetter {
				ans++
			}
		}
	}
	return ans
}
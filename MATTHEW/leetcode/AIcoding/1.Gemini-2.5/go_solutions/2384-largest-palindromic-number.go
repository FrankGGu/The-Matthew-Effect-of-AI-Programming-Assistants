func largestPalindromic(num string) string {
	counts := [10]int{}
	for _, r := range num {
		counts[r-'0']++
	}

	var firstHalf bytes.Buffer
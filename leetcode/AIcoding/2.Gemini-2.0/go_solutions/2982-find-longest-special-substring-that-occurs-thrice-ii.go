func longestSpecialSubstring(s string, k int) int {
	n := len(s)
	ans := -1
	for i := 0; i < 26; i++ {
		char := rune('a' + i)
		count := make([]int, n+1)
		for j := 0; j < n; j++ {
			if rune(s[j]) == char {
				count[j+1] = count[j] + 1
			} else {
				count[j+1] = 0
			}
		}
		freq := make([]int, n+1)
		for j := 1; j <= n; j++ {
			freq[count[j]]++
		}
		sum := 0
		for l := n; l >= 1; l-- {
			sum += freq[l]
			if sum >= k {
				ans = max(ans, l)
				break
			}
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
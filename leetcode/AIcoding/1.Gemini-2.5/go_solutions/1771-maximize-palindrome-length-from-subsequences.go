func longestPalindrome(word1 string, word2 string) int {
	s := word1 + word2
	n1 := len(word1)
	n := len(s)

	// dp[i][j] stores the length of the Longest Palindromic Subsequence (LPS) of s[i...
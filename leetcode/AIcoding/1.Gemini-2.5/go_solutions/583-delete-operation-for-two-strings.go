func minDistance(word1 string, word2 string) int {
	n1 := len(word1)
	n2 := len(word2)

	// dp[i][j] stores the length of the longest common subsequence of word1[:i] and word2[:j]
	dp := make([][]int, n1+1
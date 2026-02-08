func shortestCommonSupersequence(str1 string, str2 string) string {
	n := len(str1)
	m := len(str2)

	// dp[i][j] stores the length of the LCS of str1[0...i-1] and str2
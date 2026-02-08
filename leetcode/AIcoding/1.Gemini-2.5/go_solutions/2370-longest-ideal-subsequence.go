import "strings"

func longestIdealString(s string, k int) int {
	dp := make([]int, 26) // dp[i] stores the length of the longest ideal subsequence ending with character 'a' + i
	maxLen := 0

	for i := 0; i < len(s);
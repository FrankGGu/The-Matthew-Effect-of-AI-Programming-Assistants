func longestSubsequence(arr []int, difference int) int {
	dp := make(map[int]int)
	maxLength := 0

	for _, num := range arr {
		prevVal := num - difference
		currentLength := 1
		if length, ok := dp[prevVal]; ok {
			currentLength
func mctFromLeafValues(arr []int) int {
	n := len(arr)

	// dp[i][j] stores the minimum cost to build a subtree from leaves arr[i...j]
	dp := make([][]int, n)
	// maxArr[i][j]
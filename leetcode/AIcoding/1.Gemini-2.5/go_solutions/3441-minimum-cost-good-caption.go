import "math"

func minCostGoodCaption(words []string, costs []int, targetLength int) int {
	dp := make([]int, targetLength+1)
	dp[0] = 0
	for i := 1; i <= targetLength; i++ {
		dp[i] = math.MaxInt32
	}

	for i := 1; i <= targetLength; i++ {
		for j := 0; j < len(words); j++ {
			wordLen := len(words[j])
			wordCost := costs[j]
			if i >= wordLen && dp[i-wordLen] != math.MaxInt32 {
				dp[i] = min(dp[i], dp[i-wordLen]+wordCost)
			}
		}
	}

	if dp[targetLength] == math.MaxInt32 {
		return -1
	}
	return dp[targetLength]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
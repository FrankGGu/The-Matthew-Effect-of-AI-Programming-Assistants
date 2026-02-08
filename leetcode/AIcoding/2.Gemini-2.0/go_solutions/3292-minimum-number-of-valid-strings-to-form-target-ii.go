import (
	"fmt"
)

func minNumber(target string, words []string) int {
	n := len(target)
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = -1
	}

	for i := 1; i <= n; i++ {
		for _, word := range words {
			if i >= len(word) && target[i-len(word):i] == word {
				if i == len(word) {
					if dp[i-len(word)] == 0 {
						dp[i] = 1
					} else if dp[i] == -1 || dp[i] > 1 {
						dp[i] = 1
					}
				} else if dp[i-len(word)] != -1 {
					if dp[i] == -1 || dp[i] > dp[i-len(word)]+1 {
						dp[i] = dp[i-len(word)] + 1
					}
				}

			}
		}
	}

	return dp[n]
}
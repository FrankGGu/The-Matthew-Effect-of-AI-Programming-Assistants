package main

func minimumConcat(target string, words []string) int {
	n := len(target)
	dp := make([]int, n+1)

	const infinity = 1000000 // A sufficiently large number to represent unreachable states

	dp[0] = 0 // 0 words needed to form an empty string

	for i := 1; i <= n; i++ {
		dp[i] = infinity
	}

	for i := 1; i <= n; i++ {
		for _, word := range words {
			wordLen := len(word)
			if i >= wordLen {
				if target[i-wordLen:i] == word {
					if dp[i-wordLen] != infinity {
						dp[i] = min(dp[i], dp[i-wordLen]+1)
					}
				}
			}
		}
	}

	if dp[n] == infinity {
		return -1
	}

	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
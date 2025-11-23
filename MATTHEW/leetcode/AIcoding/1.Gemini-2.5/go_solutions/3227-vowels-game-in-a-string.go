package main

func isVowel(c byte) bool {
	return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
}

func vowelsGame(s string) bool {
	n := len(s)

	prefixVowelParity := make([]int, n+1)
	prefixVowelParity[0] = 0
	for k := 1; k <= n; k++ {
		vowelVal := 0
		if isVowel(s[k-1]) {
			vowelVal = 1
		}
		prefixVowelParity[k] = (prefixVowelParity[k-1] + vowelVal) % 2
	}

	dp := make([]bool, n+1)

	minLosingStateParity0 := n + 1
	minLosingStateParity1 := n + 1

	dp[n] = false
	if prefixVowelParity[n] == 0 {
		minLosingStateParity0 = n
	} else {
		minLosingStateParity1 = n
	}

	for i := n - 1; i >= 0; i-- {
		dp[i] = false

		if prefixVowelParity[i] == 0 {
			if minLosingStateParity1 <= n && minLosingStateParity1 > i {
				dp[i] = true
			}
		} else {
			if minLosingStateParity0 <= n && minLosingStateParity0 > i {
				dp[i] = true
			}
		}

		if !dp[i] {
			if prefixVowelParity[i] == 0 {
				minLosingStateParity0 = i
			} else {
				minLosingStateParity1 = i
			}
		}
	}

	return dp[0]
}
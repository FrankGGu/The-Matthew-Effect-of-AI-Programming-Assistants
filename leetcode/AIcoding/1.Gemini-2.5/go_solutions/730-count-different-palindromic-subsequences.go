func countPalindromicSubsequences(s string) int {
	n := len(s)
	MOD := 1000000007

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	// next_idx[i][char_code] stores the index of the next occurrence of char_code at or after i
	nextIdx := make([][]int, n)
	for i := range nextIdx {
		nextIdx[i] = make([]int, 26)
	}
	lastPos := make([]int, 26)
	for i := range lastPos {
		lastPos[i] = n // Initialize with n, meaning not found
	}
	for i := n - 1; i >= 0; i-- {
		for c := 0; c < 26; c++ {
			nextIdx[i][c] = lastPos[c]
		}
		lastPos[s[i]-'a'] = i
	}

	// prev_idx[i][char_code] stores the index of the previous occurrence of char_code at or before i
	prevIdx := make([][]int, n)
	for i := range prevIdx {
		prevIdx[i] = make([]int, 26)
	}
	firstPos := make([]int, 26)
	for i := range firstPos {
		firstPos[i] = -1 // Initialize with -1, meaning not found
	}
	for i := 0; i < n; i++ {
		for c := 0; c < 26; c++ {
			prevIdx[i][c] = firstPos[c]
		}
		firstPos[s[i]-'a'] = i
	}

	// Base cases: single characters are palindromes
	for i := 0; i < n; i++ {
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] != s[j] {
				dp[i][j] = (dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + MOD) % MOD
			} else { // s[i] == s[j]
				char_code := s[i] - 'a'
				next_i := nextIdx[i+1][char_code] // First occurrence of s[i] in s[i+1...j]
				prev_j := prevIdx[j-1][char_code] // Last occurrence of s[j] in s[i...j-1]

				if next_i > prev_j { // No character s[i] in s[i+1...j-1]
					// Palindromes are:
					// 1. Palindromes from s[i+1...j-1] (dp[i+1][j-1])
					// 2. s[i] itself (1)
					// 3. s[i]s[j] (1)
					// 4. s[i] + P + s[j] where P is any palindrome from s[i+1...j-1] (dp[i+1][j-1])
					// Total = dp[i+1][j-1] + 1 + 1 + dp[i+1][j-1] = 2 * dp[i+1][j-1] + 2
					dp[i][j] = (2*dp[i+1][j-1] + 2) % MOD
				} else if next_i == prev_j { // Exactly one character s[i] in s[i+1...j-1]
					// Palindromes are:
					// 1. Palindromes from s[i+1...j-1] (dp[i+1][j-1])
					// 2. s[i]s[j] (1)
					// 3. s[i] + P + s[j] where P is any palindrome from s[i+1...j-1] (dp[i+1][j-1])
					// The single character s[i] is counted in dp[i+1][j-1] as s[next_i].
					// So, 2 * dp[i+1][j-1] + 1
					dp[i][j] = (2*dp[i+1][j-1] + 1) % MOD
				} else { // Multiple characters s[i] in s[i+1...j-1]
					// Palindromes are:
					// 1. Palindromes from s[i+1...j-1] (dp[i+1][j-1])
					// 2. s[i]s[j] (1)
					// 3. s[i] + P + s[j] where P is any palindrome from s[i+1...j-1] (dp[i+1][j-1])
					// However, palindromes P from s[next_i+1...prev_j-1] are overcounted.
					// They are counted as P in dp[i+1][j-1] AND as s[i] + P + s[j].
					// So we subtract dp[next_i+1][prev_j-1] to correct this.
					// Total = 2 * dp[i+1][j-1] + 2 - dp[next_i+1][prev_j-1]
					// The +2 for s[i] and s[i]s[j] is implicitly handled by the formula.
					// The formula is 2 * dp[i+1][j-1] - dp[next_i+1][prev_j-1].
					// The +2 from the "no inner char" case is absorbed.
					// For example, if P is "a", it's counted. If P is "b", it's counted.
					// If s[i] is 'a', then "a" is counted.
					// If s[i] is 'a', "aa" is counted.
					// The logic is: 2 * dp[i+1][j-1] (for P and cPc) - dp[next_i+1][prev_j-1] (remove duplicates)
					dp[i][j] = (2*dp[i+1][j-1] - dp[next_i+1][prev_j-1] + MOD) % MOD
				}
			}
		}
	}

	return dp[0][n-1]
}
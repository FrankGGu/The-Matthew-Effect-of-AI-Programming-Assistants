const mod = 1000000007

func numberOfWays(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, n+1)
	}
	prefix := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		prefix[i] = make([]int, n+1)
	}

	for i := 1; i <= n; i++ {
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 1; i <= n-length+1; i++ {
			j := i + length - 1
			for k := i; k < j; k++ {
				if compare(s, i-1, k-1, k, j-1) < 0 {
					dp[i][j] = (dp[i][j] + dp[k+1][j]) % mod
				} else if compare(s, i-1, k-1, k, j-1) == 0 {
					dp[i][j] = (dp[i][j] + prefixSum(prefix, k+1, j-1, k+1, j-1)) % mod
				}
			}
			if s[i-1] != '0' {
				dp[i][j] = (dp[i][j] + 1) % mod
			}
		}
		for i := 1; i <= n-length+1; i++ {
			j := i + length - 1
			prefix[i][j] = (prefix[i][j-1] + dp[i][j]) % mod
		}
	}

	return prefix[1][n]
}

func compare(s string, i int, j int, k int, l int) int {
	len1 := j - i + 1
	len2 := l - k + 1
	if len1 < len2 {
		return -1
	} else if len1 > len2 {
		return 1
	}
	for x := 0; x < len1; x++ {
		if s[i+x] < s[k+x] {
			return -1
		} else if s[i+x] > s[k+x] {
			return 1
		}
	}
	return 0
}

func prefixSum(prefix [][]int, rowStart int, colStart int, rowEnd int, colEnd int) int {
	if rowStart > rowEnd || colStart > colEnd {
		return 0
	}
	return prefix[rowStart][colEnd]
}
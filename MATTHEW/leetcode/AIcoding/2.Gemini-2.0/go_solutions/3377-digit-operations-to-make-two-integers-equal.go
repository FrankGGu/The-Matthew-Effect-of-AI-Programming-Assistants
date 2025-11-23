import "math"

func minOperations(num1 int, num2 int) int {
	if num1 == num2 {
		return 0
	}

	s1 := toDigits(num1)
	s2 := toDigits(num2)

	m := len(s1)
	n := len(s2)

	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32
		}
	}

	dp[0][0] = 0

	for i := 0; i <= m; i++ {
		for j := 0; j <= n; j++ {
			if dp[i][j] == math.MaxInt32 {
				continue
			}

			if i < m {
				dp[i+1][j] = min(dp[i+1][j], dp[i][j]+1)
			}

			if j < n {
				dp[i][j+1] = min(dp[i][j+1], dp[i][j]+1)
			}

			if i < m && j < n {
				if s1[i] == s2[j] {
					dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j])
				} else {
					dp[i+1][j+1] = min(dp[i+1][j+1], dp[i][j]+1)
				}
			}
		}
	}

	return dp[m][n]
}

func toDigits(num int) []int {
	digits := []int{}
	for num > 0 {
		digits = append([]int{num % 10}, digits...)
		num /= 10
	}
	return digits
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
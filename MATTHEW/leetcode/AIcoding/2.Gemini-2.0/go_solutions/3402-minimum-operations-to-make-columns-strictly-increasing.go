import (
	"math"
)

func minDeletionSize(strs []string) int {
	m := len(strs)
	n := len(strs[0])
	ans := 0
	for j := 0; j < n; j++ {
		for i := 1; i < m; i++ {
			if strs[i][j] < strs[i-1][j] {
				ans++
				break
			}
		}
	}
	return ans
}

func minOperations(strs []string) int {
	m := len(strs)
	n := len(strs[0])
	dp := make([]int, n)
	for i := 0; i < n; i++ {
		dp[i] = 1
		for j := 0; j < i; j++ {
			valid := true
			for k := 0; k < len(strs); k++ {
				if strs[k][i] < strs[k][j] {
					valid = false
					break
				}
			}
			if valid {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}

	res := 0
	for i := 0; i < n; i++ {
		res = max(res, dp[i])
	}
	return n - res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func solve() {

}

func longestCommonSubsequence(text1 string, text2 string) int {
	n := len(text1)
	m := len(text2)
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, m+1)
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			if text1[i-1] == text2[j-1] {
				dp[i][j] = dp[i-1][j-1] + 1
			} else {
				dp[i][j] = max(dp[i-1][j], dp[i][j-1])
			}
		}
	}

	return dp[n][m]
}

func minDistance(word1 string, word2 string) int {
	n := len(word1)
	m := len(word2)
	dp := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = make([]int, m+1)
		dp[i][0] = i
	}

	for j := 0; j <= m; j++ {
		dp[0][j] = j
	}

	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			if word1[i-1] == word2[j-1] {
				dp[i][j] = dp[i-1][j-1]
			} else {
				dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1])) + 1
			}
		}
	}

	return dp[n][m]
}

func minFallingPathSum(matrix [][]int) int {
	n := len(matrix)
	m := len(matrix[0])
	dp := make([][]int, n)
	for i := 0; i < n; i++ {
		dp[i] = make([]int, m)
	}

	for i := 0; i < m; i++ {
		dp[0][i] = matrix[0][i]
	}

	for i := 1; i < n; i++ {
		for j := 0; j < m; j++ {
			dp[i][j] = dp[i-1][j]
			if j > 0 {
				dp[i][j] = min(dp[i][j], dp[i-1][j-1])
			}
			if j < m-1 {
				dp[i][j] = min(dp[i][j], dp[i-1][j+1])
			}
			dp[i][j] += matrix[i][j]
		}
	}

	ans := math.MaxInt32
	for i := 0; i < m; i++ {
		ans = min(ans, dp[n-1][i])
	}
	return ans
}
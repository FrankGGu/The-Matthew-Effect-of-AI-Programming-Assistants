import (
	"strings"
)

func shortestSuperstring(words []string) string {
	n := len(words)
	overlap := make([][]int, n)
	for i := 0; i < n; i++ {
		overlap[i] = make([]int, n)
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			for k := min(len(words[i]), len(words[j])); k > 0; k-- {
				if strings.HasSuffix(words[i], words[j][:k]) {
					overlap[i][j] = k
					break
				}
			}
		}
	}

	dp := make([][]string, 1<<n)
	for i := 0; i < 1<<n; i++ {
		dp[i] = make([]string, n)
	}

	parent := make([][]int, 1<<n)
	for i := 0; i < 1<<n; i++ {
		parent[i] = make([]int, n)
		for j := 0; j < n; j++ {
			parent[i][j] = -1
		}
	}

	for i := 0; i < n; i++ {
		dp[1<<i][i] = words[i]
	}

	for mask := 1; mask < (1 << n); mask++ {
		for i := 0; i < n; i++ {
			if (mask & (1 << i)) > 0 {
				for j := 0; j < n; j++ {
					if i == j || (mask & (1 << j)) == 0 {
						continue
					}
					newStr := dp[mask^(1<<i)][j] + words[i][overlap[j][i]:]
					if dp[mask][i] == "" || len(newStr) < len(dp[mask][i]) {
						dp[mask][i] = newStr
						parent[mask][i] = j
					}
				}
			}
		}
	}

	mask := (1 << n) - 1
	minLen := -1
	last := -1
	for i := 0; i < n; i++ {
		if minLen == -1 || len(dp[mask][i]) < minLen {
			minLen = len(dp[mask][i])
			last = i
		}
	}

	result := ""
	for mask > 0 {
		result = words[last] + result[len(words[last]):]
		temp := last
		last = parent[mask][last]
		mask ^= (1 << temp)
	}
	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
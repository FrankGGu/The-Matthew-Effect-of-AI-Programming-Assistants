import "fmt"

func takeCharacters(s string, k int) int {
	n := len(s)
	counts := make([]int, 3)
	for _, char := range s {
		counts[char-'a']++
	}

	if counts[0] < k || counts[1] < k || counts[2] < k {
		return -1
	}

	ans := n
	for i := 0; i <= n; i++ {
		for j := i; j <= n; j++ {
			tempCounts := make([]int, 3)
			for l := 0; l < i; l++ {
				tempCounts[s[l]-'a']++
			}
			for l := j; l < n; l++ {
				tempCounts[s[l]-'a']++
			}

			if tempCounts[0] >= k && tempCounts[1] >= k && tempCounts[2] >= k {
				ans = min(ans, i+n-j)
			}
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
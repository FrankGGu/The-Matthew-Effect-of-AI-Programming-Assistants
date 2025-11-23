import "strings"

func longestSubsequenceRepeatedK(s string, k int) string {
	n := len(s)
	ans := ""

	var backtrack func(curr string)
	backtrack = func(curr string) {
		if len(curr) > len(ans) {
			ans = curr
		}

		for i := 'a'; i <= 'z'; i++ {
			next := curr + string(i)
			count := 0
			j := 0
			for l := 0; l < n; l++ {
				if j < len(next) && s[l] == next[j] {
					j++
				}
				if j == len(next) {
					count++
					j = 0
				}
			}

			if count >= k {
				backtrack(next)
			}
		}
	}

	backtrack("")
	return ans
}
import "math"

func smallestSubstring(s string) int {
	n := len(s)
	ans := math.MaxInt32
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			valid := true
			for k := i; k <= j; k++ {
				if s[k] != s[i] {
					valid = false
					break
				}
			}
			if valid {
				ans = min(ans, j-i+1)
			}
		}
	}
	if ans == math.MaxInt32 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
import "math"

func shortestToChar(s string, c byte) []int {
	n := len(s)
	res := make([]int, n)
	pos := -n

	for i := 0; i < n; i++ {
		if s[i] == c {
			pos = i
		}
		res[i] = i - pos
	}

	pos = 2 * n
	for i := n - 1; i >= 0; i-- {
		if s[i] == c {
			pos = i
		}
		res[i] = min(res[i], pos-i)
	}

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
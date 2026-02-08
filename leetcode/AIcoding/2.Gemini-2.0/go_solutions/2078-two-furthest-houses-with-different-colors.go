import "fmt"

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

func maxDistance(colors []int) int {
	n := len(colors)
	ans := 0

	for i := 0; i < n; i++ {
		for j := n - 1; j > i; j-- {
			if colors[i] != colors[j] {
				ans = max(ans, j-i)
				break
			}
		}
	}

	return ans
}
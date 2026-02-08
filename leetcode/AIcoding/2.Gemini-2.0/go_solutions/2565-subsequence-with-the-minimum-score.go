import (
	"math"
)

func minimumScore(s string, t string) int {
	n := len(s)
	m := len(t)
	left := make([]int, m+1)
	right := make([]int, m+1)

	left[0] = -1
	j := 0
	for i := 0; i < n && j < m; i++ {
		if s[i] == t[j] {
			left[j+1] = i
			j++
		}
	}

	if j == m {
		return 0
	}

	right[m] = n
	j = m - 1
	for i := n - 1; i >= 0 && j >= 0; i-- {
		if s[i] == t[j] {
			right[j] = i
			j--
		}
	}

	ans := m - j - 1
	for i := 0; i <= m; i++ {
		l := left[i]
		low := i
		high := m
		for low < high {
			mid := (low + high) / 2
			if right[mid] > l {
				high = mid
			} else {
				low = mid + 1
			}
		}
		ans = int(math.Min(float64(ans), float64(low-i)))
	}

	return ans
}
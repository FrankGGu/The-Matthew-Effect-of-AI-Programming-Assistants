import (
	"sort"
)

func minimumRemoval(beans []int) int64 {
	sort.Ints(beans)
	n := len(beans)
	totalSum := int64(0)
	for _, bean := range beans {
		totalSum += int64(bean)
	}
	ans := totalSum - int64(beans[0]*n)
	for i := 1; i < n; i++ {
		ans = min(ans, totalSum-int64(beans[i]*(n-i)))
	}
	return ans
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}
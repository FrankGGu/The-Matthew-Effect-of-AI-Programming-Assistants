import (
	"sort"
)

func maximizeHappiness(happiness []int, k int) int {
	sort.Sort(sort.Reverse(sort.IntSlice(happiness)))
	ans := 0
	for i := 0; i < k; i++ {
		ans += happiness[i]
	}
	return ans
}
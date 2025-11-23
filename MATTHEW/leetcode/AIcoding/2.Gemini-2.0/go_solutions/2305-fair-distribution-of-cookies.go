import (
	"math"
)

func distributeCookies(cookies []int, k int) int {
	n := len(cookies)
	unfairness := math.MaxInt32

	buckets := make([]int, k)

	var backtrack func(int)
	backtrack = func(i int) {
		if i == n {
			maxUnfairness := 0
			for j := 0; j < k; j++ {
				if buckets[j] > maxUnfairness {
					maxUnfairness = buckets[j]
				}
			}
			if maxUnfairness < unfairness {
				unfairness = maxUnfairness
			}
			return
		}

		for j := 0; j < k; j++ {
			buckets[j] += cookies[i]
			backtrack(i + 1)
			buckets[j] -= cookies[i]
		}
	}

	backtrack(0)
	return unfairness
}
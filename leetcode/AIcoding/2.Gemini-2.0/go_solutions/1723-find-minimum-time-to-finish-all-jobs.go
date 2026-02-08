import (
	"math"
	"sort"
)

func minimumTimeRequired(jobs []int, k int) int {
	n := len(jobs)
	sort.Sort(sort.Reverse(sort.IntSlice(jobs)))

	var check func(int) bool
	check = func(limit int) bool {
		workers := make([]int, k)

		var backtrack func(int) bool
		backtrack = func(idx int) bool {
			if idx == n {
				return true
			}

			for i := 0; i < k; i++ {
				if workers[i]+jobs[idx] <= limit {
					workers[i] += jobs[idx]
					if backtrack(idx + 1) {
						return true
					}
					workers[i] -= jobs[idx]
					if workers[i] == 0 {
						break
					}
				}
			}
			return false
		}
		return backtrack(0)
	}

	left, right := jobs[0], 0
	for _, job := range jobs {
		right += job
	}

	ans := right
	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return ans
}
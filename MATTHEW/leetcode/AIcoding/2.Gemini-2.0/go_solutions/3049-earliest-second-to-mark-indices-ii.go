import (
	"sort"
)

func earliestSecondToMarkIndices(nums []int, changeIndices []int) int {
	n := len(nums)
	m := len(changeIndices)

	check := func(time int) bool {
		last := make([]int, n)
		for i := 0; i < n; i++ {
			last[i] = -1
		}

		used := make([]bool, time+1)

		for i := 1; i <= time; i++ {
			idx := changeIndices[i-1] - 1
			last[idx] = i
		}

		for i := 0; i < n; i++ {
			if last[i] == -1 {
				return false
			}
		}

		slots := 0
		for i := 1; i <= time; i++ {
			idx := changeIndices[i-1] - 1
			if last[idx] == i {
				if nums[idx] <= slots {
					slots -= nums[idx]
					used[i] = true
				} else {
					continue
				}

			} else {
				slots++
			}
		}

		for i := 0; i < n; i++ {
			if !used[last[i]] {
				return false
			}
		}
		return true
	}

	left := 1
	right := m

	ans := -1

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
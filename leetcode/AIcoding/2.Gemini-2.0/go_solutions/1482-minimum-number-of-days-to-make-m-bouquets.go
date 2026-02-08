import "sort"

func minDays(bloomDay []int, m int, k int) int {
	n := len(bloomDay)
	if m*k > n {
		return -1
	}

	left, right := 1, 1
	for _, day := range bloomDay {
		if day > right {
			right = day
		}
	}

	ans := right

	for left <= right {
		mid := left + (right-left)/2
		bouquets := 0
		flowers := 0
		for _, day := range bloomDay {
			if day <= mid {
				flowers++
				if flowers == k {
					bouquets++
					flowers = 0
				}
			} else {
				flowers = 0
			}
		}

		if bouquets >= m {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}
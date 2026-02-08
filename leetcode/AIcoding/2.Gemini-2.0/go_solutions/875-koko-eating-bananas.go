import "sort"

func minEatingSpeed(piles []int, h int) int {
	l, r := 1, 0
	for _, pile := range piles {
		if pile > r {
			r = pile
		}
	}

	for l < r {
		mid := l + (r-l)/2
		hours := 0
		for _, pile := range piles {
			hours += (pile + mid - 1) / mid
		}

		if hours <= h {
			r = mid
		} else {
			l = mid + 1
		}
	}

	return l
}
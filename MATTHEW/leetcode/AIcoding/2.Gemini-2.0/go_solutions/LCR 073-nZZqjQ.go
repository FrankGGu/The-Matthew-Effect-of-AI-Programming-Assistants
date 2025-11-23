func minEatingSpeed(piles []int, h int) int {
	l, r := 1, 0
	for _, pile := range piles {
		if pile > r {
			r = pile
		}
	}

	ans := r
	for l <= r {
		mid := l + (r-l)/2
		hours := 0
		for _, pile := range piles {
			hours += (pile + mid - 1) / mid
		}

		if hours <= h {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return ans
}
func shipWithinDays(weights []int, days int) int {
	left, right := 0, 0
	for _, w := range weights {
		if w > left {
			left = w
		}
		right += w
	}

	for left < right {
		mid := left + (right-left)/2
		need, cur := 1, 0
		for _, w := range weights {
			if cur+w > mid {
				need++
				cur = 0
			}
			cur += w
		}

		if need > days {
			left = mid + 1
		} else {
			right = mid
		}
	}

	return left
}
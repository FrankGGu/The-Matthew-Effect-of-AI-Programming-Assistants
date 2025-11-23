func minCapability(nums []int, k int) int {
	left, right := 1, 0
	for _, num := range nums {
		if num > right {
			right = num
		}
	}

	for left < right {
		mid := left + (right-left)/2
		count := 0
		robbed := false
		for _, num := range nums {
			if num <= mid && !robbed {
				count++
				robbed = true
			} else {
				robbed = false
			}
		}

		if count >= k {
			right = mid
		} else {
			left = mid + 1
		}
	}

	return left
}
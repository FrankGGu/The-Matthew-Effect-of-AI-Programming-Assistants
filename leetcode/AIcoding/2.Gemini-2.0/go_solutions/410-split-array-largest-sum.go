func splitArray(nums []int, k int) int {
	left, right := 0, 0
	for _, num := range nums {
		right += num
		if num > left {
			left = num
		}
	}

	for left < right {
		mid := left + (right-left)/2
		count := 1
		sum := 0
		for _, num := range nums {
			if sum+num > mid {
				count++
				sum = num
			} else {
				sum += num
			}
		}

		if count > k {
			left = mid + 1
		} else {
			right = mid
		}
	}

	return left
}
package main

func maxValue(n int, index int, maxSum int) int {
	left := 1
	right := maxSum

	for left < right {
		mid := (left + right + 1) / 2
		sum := 0

		// Calculate sum of left part
		if index >= mid-1 {
			sum += (mid-1)*mid/2
		} else {
			sum += (mid-1)*mid/2 - (mid-1-index)*(mid-1-index)/2
		}

		// Calculate sum of right part
		if n-index >= mid-1 {
			sum += (mid-1)*mid/2
		} else {
			sum += (mid-1)*mid/2 - (mid-1-(n-index))*(mid-1-(n-index))/2
		}

		sum += mid

		if sum <= maxSum {
			left = mid
		} else {
			right = mid - 1
		}
	}

	return left
}
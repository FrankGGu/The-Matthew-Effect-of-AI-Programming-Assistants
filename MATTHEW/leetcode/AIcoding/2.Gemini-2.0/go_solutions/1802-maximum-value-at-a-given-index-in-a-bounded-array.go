func maxValue(n int, index int, maxSum int) int {
	low := 1
	high := maxSum

	for low < high {
		mid := (low + high + 1) / 2
		sum := calculateSum(n, index, mid)

		if sum <= maxSum {
			low = mid
		} else {
			high = mid - 1
		}
	}

	return low
}

func calculateSum(n int, index int, value int) int {
	sum := 0
	if value > index {
		sum += (value + value - index) * (index + 1) / 2
	} else {
		sum += (value + 1) * value / 2 + index - value + 1
	}

	if value >= n-index {
		sum += (value + value - (n - 1 - index)) * (n - index) / 2
	} else {
		sum += (value + 1) * value / 2 + (n - 1 - index) - value + 1
	}

	return sum - value
}
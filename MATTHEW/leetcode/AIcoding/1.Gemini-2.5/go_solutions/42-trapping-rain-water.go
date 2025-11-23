func trap(height []int) int {
	n := len(height)
	if n <= 2 {
		return 0
	}

	left := 0
	right := n - 1
	maxLeft := 0
	maxRight := 0
	water := 0

	for left < right {
		if height[left] < height[right] {
			if height[left] >= maxLeft {
				maxLeft = height[left]
			} else {
				water += maxLeft - height[left]
			}
			left++
		} else {
			if height[right] >= maxRight {
				maxRight = height[right]
			} else {
				water += maxRight - height[right]
			}
			right--
		}
	}

	return water
}
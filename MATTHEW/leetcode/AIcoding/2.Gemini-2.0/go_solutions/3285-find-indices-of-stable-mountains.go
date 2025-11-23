func findValley(mountain []int) []int {
	n := len(mountain)
	if n < 3 {
		return []int{-1, -1, -1}
	}
	left := 0
	right := n - 1
	for left < right {
		mid := left + (right-left)/2
		if mountain[mid] > mountain[mid+1] {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return []int{left - 1, left, left + 1}
}

func findPeaks(mountain []int) []int {
	n := len(mountain)
	if n < 3 {
		return []int{-1, -1, -1}
	}
	left := 0
	right := n - 1
	for left < right {
		mid := left + (right-left)/2
		if mountain[mid] < mountain[mid+1] {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return []int{left - 1, left, left + 1}
}
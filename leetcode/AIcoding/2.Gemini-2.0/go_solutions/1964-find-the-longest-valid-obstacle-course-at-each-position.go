func longestObstacleCourseAtEachPosition(obstacles []int) []int {
	n := len(obstacles)
	result := make([]int, n)
	tails := []int{}

	for i, obstacle := range obstacles {
		idx := upper_bound(tails, obstacle)
		if idx == len(tails) {
			tails = append(tails, obstacle)
			result[i] = len(tails)
		} else {
			tails[idx] = obstacle
			result[i] = idx + 1
		}
	}

	return result
}

func upper_bound(arr []int, target int) int {
	left, right := 0, len(arr)
	for left < right {
		mid := left + (right-left)/2
		if arr[mid] <= target {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return left
}
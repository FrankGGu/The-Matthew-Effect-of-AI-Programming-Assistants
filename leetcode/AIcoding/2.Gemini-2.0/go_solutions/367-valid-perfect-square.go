func isPerfectSquare(num int) bool {
	low, high := 1, num
	for low <= high {
		mid := low + (high-low)/2
		square := mid * mid
		if square == num {
			return true
		} else if square < num {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return false
}
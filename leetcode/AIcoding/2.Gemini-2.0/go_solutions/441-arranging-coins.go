func arrangeCoins(n int) int {
	left, right := 0, n
	for left <= right {
		mid := left + (right-left)/2
		coinsNeeded := mid * (mid + 1) / 2
		if coinsNeeded == n {
			return mid
		} else if coinsNeeded < n {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	return right
}
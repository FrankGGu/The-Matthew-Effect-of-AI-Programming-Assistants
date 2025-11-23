func preimageSizeFZF(k int) int {
	return count(k) - count(k-1)
}

func count(k int) int {
	low, high := 0, 5*k+1
	for low <= high {
		mid := low + (high-low)/2
		zeros := trailingZeroes(mid)
		if zeros <= k {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return low
}

func trailingZeroes(n int) int {
	count := 0
	for n > 0 {
		n /= 5
		count += n
	}
	return count
}
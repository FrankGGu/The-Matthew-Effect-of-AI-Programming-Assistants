func mySqrt(x int) int {
	if x < 2 {
		return x
	}

	low := 0
	high := x
	ans := 0

	for low <= high {
		mid := low + (high-low)/2
		// Using int64 for square to prevent potential overflow if x is very large,
		// though for x up to 2^31-1, mid*mid fits in int.
		// It's a good practice for square root problems.
		// However, given x is int, mid will also be int.
		// For x up to 2^31-1, max sqrt is 46340, 46340*46340 = 2147395600, which fits in int32.
		// So int(mid*mid) is fine here.
		square := mid * mid

		if square == x {
			return mid
		} else if square < x {
			ans = mid
			low = mid + 1
		} else { // square > x
			high = mid - 1
		}
	}
	return ans
}
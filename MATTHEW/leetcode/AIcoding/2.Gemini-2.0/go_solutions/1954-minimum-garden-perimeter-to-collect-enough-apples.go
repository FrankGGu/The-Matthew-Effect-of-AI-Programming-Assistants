func minimumPerimeter(neededApples int64) int64 {
	l, r := int64(0), int64(100000)
	ans := int64(0)

	for l <= r {
		mid := l + (r-l)/2
		apples := 2 * mid * (mid + 1) * (2*mid + 1)
		if apples >= neededApples {
			ans = mid
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return 8 * ans
}
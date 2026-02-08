func nthUglyNumber(n int, a int, b int, c int) int {
	low := 1
	high := 2 * int(1e9)

	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	lcm := func(a, b int) int {
		return a * b / gcd(a, b)
	}

	for low < high {
		mid := low + (high-low)/2
		count := mid/a + mid/b + mid/c - mid/lcm(a, b) - mid/lcm(a, c) - mid/lcm(b, c) + mid/lcm(lcm(a, b), c)
		if count < n {
			low = mid + 1
		} else {
			high = mid
		}
	}

	return low
}
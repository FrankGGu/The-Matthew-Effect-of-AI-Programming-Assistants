func nthMagicalNumber(n int, a int, b int) int {
	lcm := a * b / gcd(a, b)
	low := 0
	high := int(1e15)
	mod := int(1e9 + 7)

	for low < high {
		mid := low + (high-low)/2
		count := mid/a + mid/b - mid/lcm
		if count < n {
			low = mid + 1
		} else {
			high = mid
		}
	}
	return low % mod
}

func gcd(a int, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}
func makeIntegerBeautiful(n int64, target int) int64 {
	sum := func(x int64) int {
		s := 0
		for x > 0 {
			s += int(x % 10)
			x /= 10
		}
		return s
	}

	if sum(n) <= target {
		return 0
	}

	s := 1
	nn := n
	for sum(nn) > target {
		r := nn % 10
		nn /= 10
		res := int64(10-r) * int64(s)
		n += res
		nn = n / int64(s * 10)
		s *= 10
	}
	return n - nn*int64(s*10) - (n-nn*int64(s*10))
}
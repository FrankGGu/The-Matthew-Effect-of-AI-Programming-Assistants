func makeTheIntegerZero(num1 int, num2 int) int {
	if num2 >= 0 {
		return -1
	}

	for k := 0; k <= 60; k++ {
		n := num1 - int(k)*num2
		if n <= 0 {
			continue
		}
		bits := 0
		temp := n
		for temp > 0 {
			bits += temp & 1
			temp >>= 1
		}

		if bits <= k && k <= n {
			return k
		}
	}

	return -1
}
func myPow(x float64, n int) float64 {
	if n == 0 {
		return 1.0
	}

	var N int64 = int64(n)
	if N < 0 {
		x = 1 / x
		N = -N
	}

	ans := 1.0
	currentProduct := x

	for N > 0 {
		if N%2 == 1 {
			ans *= currentProduct
		}
		currentProduct *= currentProduct
		N /= 2
	}

	return ans
}
func findIntegers(n int) int {
	fib := make([]int, 32)
	fib[0] = 1
	fib[1] = 2
	for i := 2; i < 32; i++ {
		fib[i] = fib[i-1] + fib[i-2]
	}

	ans := 0
	prevBit := 0
	for i := 31; i >= 0; i-- {
		bit := (n >> i) & 1
		if bit == 1 {
			ans += fib[i]
			if prevBit == 1 {
				return ans
			}
			prevBit = 1
		} else {
			prevBit = 0
		}
	}

	return ans + 1
}
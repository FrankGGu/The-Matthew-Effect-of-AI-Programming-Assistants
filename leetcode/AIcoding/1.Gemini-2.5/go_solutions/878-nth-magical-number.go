package main

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func nthMagicalNumber(n int, a int, b int) int {
	MOD := int64(1000000007)

	commonDivisor := gcd(a, b)
	leastCommonMultiple := (int64(a) / int64(commonDivisor)) * int64(b)

	low := int64(1)
	high := int64(n) * int64(max(a, b))

	ans := int64(0)

	for low <= high {
		mid := low + (high-low)/2

		count := mid/int64(a) + mid/int64(b) - mid/leastCommonMultiple

		if count < int64(n) {
			low = mid + 1
		} else {
			ans = mid
			high = mid - 1
		}
	}

	return int(ans % MOD)
}
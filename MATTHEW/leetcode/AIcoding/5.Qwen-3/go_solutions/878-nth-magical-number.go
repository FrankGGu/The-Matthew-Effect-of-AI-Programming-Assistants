package main

func nthMagicalNumber(n int, k int) int {
	const MOD = 1000000007
	low, high := int64(1), int64(k)*int64(n)
	for low < high {
		mid := (low + high) / 2
		if mid/k*int64(n) < int64(n) {
			low = mid + 1
		} else {
			high = mid
		}
	}
	return int(low % MOD)
}
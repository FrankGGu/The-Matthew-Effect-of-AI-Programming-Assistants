func clearTheNthBit(number int, n int) int {
	mask := 1 << (n - 1)
	mask = ^mask
	return number & mask
}
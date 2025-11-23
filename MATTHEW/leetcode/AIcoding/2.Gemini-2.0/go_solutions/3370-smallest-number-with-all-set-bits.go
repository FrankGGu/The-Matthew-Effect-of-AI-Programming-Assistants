func smallestNumber(n int) int {
	res := 0
	for i := 0; i < 32; i++ {
		if n&(1<<i) != 0 {
			res = (1 << (i + 1)) - 1
			break
		}
	}
	return res
}
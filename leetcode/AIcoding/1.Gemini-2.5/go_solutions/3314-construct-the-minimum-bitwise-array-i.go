func constructTheMinimumBitwiseArray(n int) []int {
	ans := make([]int, n)
	currentPowerOfTwo := 1
	for i := 0; i < n; i++ {
		ans[i] = currentPowerOfTwo
		currentPowerOfTwo <<= 1
	}
	return ans
}
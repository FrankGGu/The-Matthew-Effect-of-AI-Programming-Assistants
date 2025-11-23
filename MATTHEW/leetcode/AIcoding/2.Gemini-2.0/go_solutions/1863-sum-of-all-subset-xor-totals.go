func subsetXORSum(nums []int) int {
	n := len(nums)
	sum := 0
	for i := 0; i < (1 << n); i++ {
		xor := 0
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				xor ^= nums[j]
			}
		}
		sum += xor
	}
	return sum
}
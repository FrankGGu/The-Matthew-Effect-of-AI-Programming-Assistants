func maximumSumOfSquares(nums []int, k int) int64 {
	cnt := [32]int{}
	n := len(nums)
	for i := 0; i < n; i++ {
		for j := 0; j < 32; j++ {
			if nums[i]&(1<<j) != 0 {
				cnt[j]++
			}
		}
	}

	res := make([]int, n)
	for i := 0; i < n; i++ {
		for j := 0; j < 32; j++ {
			if cnt[j] > 0 && k > 0 {
				res[i] |= (1 << j)
				cnt[j]--
				k--
			}
		}
	}

	ans := int64(0)
	for i := 0; i < n; i++ {
		ans += int64(res[i]) * int64(res[i])
	}

	return ans
}
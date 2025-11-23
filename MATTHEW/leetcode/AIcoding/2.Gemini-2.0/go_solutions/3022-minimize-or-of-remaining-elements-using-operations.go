func minimizeOR(nums []int, k int) int {
	n := len(nums)
	ans := 0
	for i := 30; i >= 0; i-- {
		bit := 1 << i
		cnt := 0
		for j := 0; j < n; j++ {
			if (nums[j]&bit) > 0 {
				cnt++
			}
		}
		if cnt > k {
			ans |= bit
		} else {
			k -= cnt
		}
	}
	return ans
}
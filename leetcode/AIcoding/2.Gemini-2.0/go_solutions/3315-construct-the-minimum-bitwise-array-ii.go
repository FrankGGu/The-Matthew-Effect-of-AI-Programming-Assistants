func minOrAfterOperations(nums []int, k int) int {
	n := len(nums)
	ans := 0
	for i := 30; i >= 0; i-- {
		need := 0
		curr := ans | (1 << i)
		temp := 0
		for j := 0; j < n; j++ {
			if (temp | nums[j])&curr != curr {
				need++
				temp = 0
			} else {
				temp |= nums[j]
			}
		}
		if need > k {
			ans |= (1 << i)
		}
	}
	return ans
}
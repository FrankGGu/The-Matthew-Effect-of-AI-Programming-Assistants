func maxOperations(nums []int) int {
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		if nums[i] == 0 {
			for j := i + 1; j < n; j++ {
				if nums[j] == 1 {
					nums[i], nums[j] = nums[j], nums[i]
					ans++
					break
				}
			}
		}
	}
	return ans
}
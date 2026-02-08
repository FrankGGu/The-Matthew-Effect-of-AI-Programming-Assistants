func checkSubarraySum(nums []int, k int) bool {
	m := map[int]int{0: -1}
	sum := 0
	for i := 0; i < len(nums); i++ {
		sum += nums[i]
		if k != 0 {
			sum %= k
		}
		if prev, ok := m[sum]; ok {
			if i-prev > 1 {
				return true
			}
		} else {
			m[sum] = i
		}
	}
	return false
}
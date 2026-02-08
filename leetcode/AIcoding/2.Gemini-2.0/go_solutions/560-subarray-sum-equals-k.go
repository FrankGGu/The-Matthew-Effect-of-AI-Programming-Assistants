func subarraySum(nums []int, k int) int {
	count := 0
	sum := 0
	m := make(map[int]int)
	m[0] = 1
	for i := 0; i < len(nums); i++ {
		sum += nums[i]
		if val, ok := m[sum-k]; ok {
			count += val
		}
		m[sum]++
	}
	return count
}
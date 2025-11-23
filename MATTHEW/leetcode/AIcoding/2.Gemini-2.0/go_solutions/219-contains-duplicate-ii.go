func containsNearbyDuplicate(nums []int, k int) bool {
	m := make(map[int]int)
	for i, num := range nums {
		if j, ok := m[num]; ok {
			if i-j <= k {
				return true
			}
		}
		m[num] = i
	}
	return false
}
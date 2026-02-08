func twoSum(price []int, target int) []int {
	m := make(map[int]int)
	for i, v := range price {
		complement := target - v
		if j, ok := m[complement]; ok {
			return []int{j, i}
		}
		m[v] = i
	}
	return []int{}
}
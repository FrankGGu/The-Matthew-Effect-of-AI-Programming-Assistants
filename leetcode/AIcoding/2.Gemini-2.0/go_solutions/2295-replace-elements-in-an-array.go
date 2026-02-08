func arrayChange(nums []int, operations [][]int) []int {
	m := make(map[int]int)
	for i, num := range nums {
		m[num] = i
	}

	for _, op := range operations {
		index := m[op[0]]
		nums[index] = op[1]
		delete(m, op[0])
		m[op[1]] = index
	}

	return nums
}
func tupleSameProduct(nums []int) int {
	count := 0
	m := make(map[int]int)
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			prod := nums[i] * nums[j]
			m[prod]++
		}
	}
	for _, v := range m {
		count += v * (v - 1) * 4
	}
	return count
}
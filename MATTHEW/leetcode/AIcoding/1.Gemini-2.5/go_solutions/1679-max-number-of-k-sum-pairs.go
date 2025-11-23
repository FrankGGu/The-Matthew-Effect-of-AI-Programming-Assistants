func maxOperations(nums []int, k int) int {
	counts := make(map[int]int)
	operations := 0

	for _, num := range nums {
		complement := k - num
		if counts[complement] > 0 {
			operations++
			counts[complement]--
		} else {
			counts[num]++
		}
	}
	return operations
}
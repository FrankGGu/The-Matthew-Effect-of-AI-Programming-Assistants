func minimumOperations(nums []int) int {
	s := make(map[int]bool)
	for _, num := range nums {
		if num > 0 {
			s[num] = true
		}
	}
	return len(s)
}
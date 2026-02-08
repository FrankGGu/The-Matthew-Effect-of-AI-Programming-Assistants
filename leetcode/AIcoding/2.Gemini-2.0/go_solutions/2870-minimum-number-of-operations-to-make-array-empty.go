func minOperations(nums []int) int {
	count := make(map[int]int)
	for _, num := range nums {
		count[num]++
	}

	res := 0
	for _, c := range count {
		if c == 1 {
			return -1
		}
		res += (c + 2) / 3
	}

	return res
}
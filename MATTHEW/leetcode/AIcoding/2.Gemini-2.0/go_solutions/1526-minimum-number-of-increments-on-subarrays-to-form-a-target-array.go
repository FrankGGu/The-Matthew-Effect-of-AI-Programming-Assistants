func minNumberOperations(target []int) int {
	res := 0
	prev := 0
	for _, num := range target {
		if num > prev {
			res += num - prev
		}
		prev = num
	}
	return res
}
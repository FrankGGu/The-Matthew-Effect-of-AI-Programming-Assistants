func findOriginalArray(changed []int) []int {
	n := len(changed)
	if n%2 != 0 {
		return []int{}
	}

	sort.Ints(changed)

	counts := make(map[int]int)
	for _, num
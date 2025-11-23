func findMaximumXOR(nums []int) int {
	max := 0
	mask := 0
	seen := make(map[int]bool)

	for i := 31; i >= 0; i-- {
		mask |= (1 << i)
		seen = make(map[int]bool)

		for _, num := range nums {
			seen[num&mask] = true
		}

		potentialMax := max | (1 << i)
		for prefix := range seen {
			if _, ok := seen[potentialMax^prefix]; ok {
				max = potentialMax
				break
			}
		}
	}

	return max
}
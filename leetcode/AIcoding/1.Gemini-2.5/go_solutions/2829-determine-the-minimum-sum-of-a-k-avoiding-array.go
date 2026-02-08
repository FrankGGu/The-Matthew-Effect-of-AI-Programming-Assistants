func minimumSum(n int, k int) int {
	sum := 0
	count := 0
	num := 1
	forbidden := make(map[int]bool) // Use a map as a set to track numbers that cannot be chosen

	for count < n {
		if !forbidden[num] {
			sum += num
			count++
			// If 'num' is chosen, then 'k - num' cannot be chosen later,
			// provided 'k - num' is a distinct positive integer.
			if k-num > 0 && k-num != num {
				forbidden[k-num] = true
			}
		}
		num++
	}

	return sum
}
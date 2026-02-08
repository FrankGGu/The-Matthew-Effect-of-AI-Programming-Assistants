func findTheWinner(n int, k int) int {
	people := make([]bool, n)
	count := 0
	curr := 0
	eliminated := 0

	for eliminated < n-1 {
		if !people[curr] {
			count++
			if count == k {
				people[curr] = true
				eliminated++
				count = 0
			}
		}
		curr = (curr + 1) % n
	}

	for i := 0; i < n; i++ {
		if !people[i] {
			return i + 1
		}
	}
	return -1
}
func isMagic(target []int) bool {
	n := len(target)
	if n == 0 {
		return true
	}

	q := make([]int, n)
	for i := 0; i < n; i++ {
		q[i] = i + 1
	}

	deck := make([]int, 0)
	for len(q) > 0 {
		deck = append(deck, q[0])
		q = q[1:]
		if len(q) > 0 {
			q = append(q, q[0])
			q = q[1:]
		}
	}

	for i := 0; i < n; i++ {
		if deck[i] != target[i] {
			return false
		}
	}

	return true
}
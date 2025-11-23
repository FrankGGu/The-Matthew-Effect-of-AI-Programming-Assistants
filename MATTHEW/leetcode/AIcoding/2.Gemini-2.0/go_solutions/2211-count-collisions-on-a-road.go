func countCollisions(directions string) int {
	n := len(directions)
	collisions := 0
	l := 0
	r := n - 1

	for l < n && directions[l] == 'L' {
		l++
	}
	for r >= 0 && directions[r] == 'R' {
		r--
	}

	for i := l; i <= r; i++ {
		if directions[i] != 'S' {
			collisions++
		}
	}

	return collisions
}
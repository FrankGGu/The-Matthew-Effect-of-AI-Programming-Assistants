func wateringPlants(plants []int, capacityA int, capacityB int) int {
	n := len(plants)
	a := capacityA
	b := capacityB
	steps := 0
	l, r := 0, n-1
	for l <= r {
		if l == r {
			if a >= plants[l] || b >= plants[l] {
				steps++
			} else {
				steps += 2
			}
			break
		}

		if a >= plants[l] {
			a -= plants[l]
			steps++
		} else {
			a = capacityA
			a -= plants[l]
			steps++
		}

		if b >= plants[r] {
			b -= plants[r]
			steps++
		} else {
			b = capacityB
			b -= plants[r]
			steps++
		}

		l++
		r--
	}
	return steps
}
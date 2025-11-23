func findAllPeople(n int, meetings [][]int, firstPerson int) []int {
	adj := make([][]int, n)
	for _, meeting := range meetings {
		x, y, t := meeting[0], meeting[1], meeting[2]
		adj[x] = append(adj[x], y*1000000000+t)
		adj[y] = append(adj[y], x*1000000000+t)
	}

	known := make([]int, n)
	for i := 0; i < n; i++ {
		known[i] = -1
	}
	known[0] = 0
	known[firstPerson] = 0

	q := []int{0, firstPerson}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for _, neighborData := range adj[curr] {
			neighbor := neighborData / 1000000000
			time := neighborData % 1000000000

			if known[neighbor] == -1 || time < known[neighbor] {
				known[neighbor] = time
				q = append(q, neighbor)
			}
		}
	}

	result := []int{}
	for i := 0; i < n; i++ {
		if known[i] != -1 {
			result = append(result, i)
		}
	}

	return result
}
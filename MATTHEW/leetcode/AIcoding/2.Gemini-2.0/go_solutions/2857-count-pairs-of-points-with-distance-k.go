func countPairs(points [][]int, k int) int {
	count := 0
	m := make(map[int]map[int]int)
	for _, p := range points {
		x, y := p[0], p[1]
		if _, ok := m[x]; !ok {
			m[x] = make(map[int]int)
		}
		m[x][y]++
	}

	for x1 := range m {
		for y1 := range m[x1] {
			for x2 := range m {
				for y2 := range m[x2] {
					if (x1^x2)+(y1^y2) == k {
						if x1 == x2 && y1 == y2 {
							count += m[x1][y1] * (m[x1][y1] - 1) / 2
						} else if x1 < x2 || (x1 == x2 && y1 < y2) {
							count += m[x1][y1] * m[x2][y2]
						}
					}
				}
			}
		}
	}

	return count
}
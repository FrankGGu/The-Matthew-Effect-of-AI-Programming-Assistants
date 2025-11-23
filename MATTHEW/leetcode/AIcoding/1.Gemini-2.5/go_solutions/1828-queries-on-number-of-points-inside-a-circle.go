func countPoints(points [][]int, queries [][]int) []int {
	ans := make([]int, len(queries))

	for i, q := range queries {
		cx, cy, r := q[0], q[1], q[2]
		rSq := r * r
		count := 0
		for _, p := range points {
			px, py := p[0], p[1]
			dx := px - cx
			dy := py - cy
			distSq := dx*dx + dy*dy
			if distSq <= rSq {
				count++
			}
		}
		ans[i] = count
	}

	return ans
}
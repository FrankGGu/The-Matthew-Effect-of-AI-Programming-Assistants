type DetectSquares struct {
	points map[int]map[int]int
}

func Constructor() DetectSquares {
	return DetectSquares{
		points: make(map[int]map[int]int),
	}
}

func (this *DetectSquares) Add(point []int) {
	x, y := point[0], point[1]
	if _, ok := this.points[x]; !ok {
		this.points[x] = make(map[int]int)
	}
	this.points[x][y]++
}

func (this *DetectSquares) Count(point []int) int {
	x1, y1 := point[0], point[1]
	totalSquares := 0

	yCounts, ok := this.points[x1]
	if !ok {
		return 0
	}

	for y_k, count_yk := range yCounts {
		if y_k == y1 {
			continue
		}

		side := y1 - y_k
		if side < 0 {
			side = -side
		}

		x_candidate_plus := x1 + side
		if x_candidate_plus <= 1000 {
			count_p3 := this.points[x_candidate_plus][y1]
			count_p4 := this.points[x_candidate_plus][y_k]
			totalSquares += count_yk * count_p3 * count_p4
		}

		x_candidate_minus := x1 - side
		if x_candidate_minus >= 0 {
			count_p3 := this.points[x_candidate_minus][y1]
			count_p4 := this.points[x_candidate_minus][y_k]
			totalSquares += count_yk * count_p3 * count_p4
		}
	}

	return totalSquares
}
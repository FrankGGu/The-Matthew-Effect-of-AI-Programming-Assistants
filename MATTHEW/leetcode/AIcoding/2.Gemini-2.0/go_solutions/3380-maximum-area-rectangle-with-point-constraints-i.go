import "sort"

func maxAreaRect(points [][]int) int {
	n := len(points)
	if n < 2 {
		return 0
	}

	xMap := make(map[int][]int)
	for _, p := range points {
		xMap[p[0]] = append(xMap[p[0]], p[1])
	}

	xVals := make([]int, 0, len(xMap))
	for x := range xMap {
		xVals = append(xVals, x)
	}
	sort.Ints(xVals)

	for x := range xMap {
		sort.Ints(xMap[x])
	}

	maxArea := 0
	for i := 0; i < len(xVals); i++ {
		for j := i + 1; j < len(xVals); j++ {
			x1 := xVals[i]
			x2 := xVals[j]
			ySet := make(map[int]bool)
			for _, y := range xMap[x1] {
				ySet[y] = true
			}

			candidates := []int{}
			for _, y := range xMap[x2] {
				if ySet[y] {
					candidates = append(candidates, y)
				}
			}

			if len(candidates) >= 2 {
				sort.Ints(candidates)
				y1 := candidates[0]
				y2 := candidates[len(candidates)-1]
				area := (x2 - x1) * (y2 - y1)
				if area > maxArea {
					maxArea = area
				}
			}
		}
	}

	return maxArea
}
import "sort"

func minAreaFreeRect(points [][]int) float64 {
	n := len(points)
	pointMap := make(map[int]map[int]bool)
	for _, p := range points {
		x, y := p[0], p[1]
		if _, ok := pointMap[x]; !ok {
			pointMap[x] = make(map[int]bool)
		}
		pointMap[x][y] = true
	}

	var ans float64 = 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			p1, p2 := points[i], points[j]
			x1, y1 := p1[0], p1[1]
			x2, y2 := p2[0], p2[1]
			dx, dy := x2-x1, y2-y1
			if dx == 0 && dy == 0 {
				continue
			}

			for k := j + 1; k < n; k++ {
				p3 := points[k]
				x3, y3 := p3[0], p3[1]

				dx2, dy2 := x3-x1, y3-y1
				if dx2 == 0 && dy2 == 0 {
					continue
				}
				if dx*dx2+dy*dy2 != 0 {
					continue
				}

				x4, y4 := x2+x3-x1, y2+y3-y1
				if _, ok := pointMap[x4]; ok {
					if _, ok2 := pointMap[x4][y4]; ok2 {
						area := float64(distance(x1, y1, x2, y2)) * float64(distance(x1, y1, x3, y3))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}
			}
		}
	}

	if ans == 0 {
		return 0
	}
	return ans
}

func distance(x1, y1, x2, y2 int) int {
	dx := x2 - x1
	dy := y2 - y1
	return dx*dx + dy*dy
}

func minAreaFreeRect2(points [][]int) float64 {
	n := len(points)
	if n < 4 {
		return 0
	}

	pointSet := make(map[int]bool)
	for _, p := range points {
		pointSet[p[0]*40001+p[1]] = true
	}

	ans := float64(0)

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				x1, y1 := points[i][0], points[i][1]
				x2, y2 := points[j][0], points[j][1]
				x3, y3 := points[k][0], points[k][1]

				dx1 := x2 - x1
				dy1 := y2 - y1
				dx2 := x3 - x1
				dy2 := y3 - y1

				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x2 + x3 - x1
					y4 := y2 + y3 - y1
					if pointSet[x4*40001+y4] {
						area := float64(distance(x1, y1, x2, y2)) * float64(distance(x1, y1, x3, y3))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}

				dx1 = x1 - x2
				dy1 = y1 - y2
				dx2 = x3 - x2
				dy2 = y3 - y2
				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x1 + x3 - x2
					y4 := y1 + y3 - y2
					if pointSet[x4*40001+y4] {
						area := float64(distance(x2, y2, x1, y1)) * float64(distance(x2, y2, x3, y3))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}

				dx1 = x1 - x3
				dy1 = y1 - y3
				dx2 = x2 - x3
				dy2 = y2 - y3
				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x1 + x2 - x3
					y4 := y1 + y2 - y3
					if pointSet[x4*40001+y4] {
						area := float64(distance(x3, y3, x1, y1)) * float64(distance(x3, y3, x2, y2))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}
			}
		}
	}

	if ans == 0 {
		return 0
	}

	return math.Sqrt(ans)
}

import "math"

func minAreaFreeRect3(points [][]int) float64 {
	n := len(points)
	pointSet := make(map[int]bool)
	for _, p := range points {
		pointSet[p[0]*40001+p[1]] = true
	}

	ans := float64(0)

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			x1, y1 := points[i][0], points[i][1]
			x2, y2 := points[j][0], points[j][1]

			for k := j + 1; k < n; k++ {
				x3, y3 := points[k][0], points[k][1]

				dx1 := x2 - x1
				dy1 := y2 - y1
				dx2 := x3 - x1
				dy2 := y3 - y1

				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x2 + x3 - x1
					y4 := y2 + y3 - y1
					if pointSet[x4*40001+y4] {
						area := float64(math.Sqrt(float64(distance(x1, y1, x2, y2)))) * float64(math.Sqrt(float64(distance(x1, y1, x3, y3))))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}

				dx1 = x1 - x2
				dy1 = y1 - y2
				dx2 = x3 - x2
				dy2 = y3 - y2
				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x1 + x3 - x2
					y4 := y1 + y3 - y2
					if pointSet[x4*40001+y4] {
						area := float64(math.Sqrt(float64(distance(x2, y2, x1, y1)))) * float64(math.Sqrt(float64(distance(x2, y2, x3, y3))))
						if ans == 0 || area < ans {
							ans = area
						}
					}
				}

				dx1 = x1 - x3
				dy1 = y1 - y3
				dx2 = x2 - x3
				dy2 = y2 - y3
				if dx1*dx2+dy1*dy2 == 0 {
					x4 := x1 + x2 - x3
					y4 := y1 + y2 - y3
					if pointSet[x4*40001+y4] {
						area := float64(math.Sqrt(float64(distance(x3
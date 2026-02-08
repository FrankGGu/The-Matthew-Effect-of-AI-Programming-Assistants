package main


func maxPoints(points []Point) int {
	if len(points) <= 1 {
		return len(points)
	}
	maxPoints := 0
	for i := 0; i < len(points); i++ {
		m := make(map[string]int)
		duplicates := 0
		currentMax := 0
		for j := 0; j < len(points); j++ {
			if i == j {
				continue
			}
			if points[i].X == points[j].X && points[i].Y == points[j].Y {
				duplicates++
				continue
			}
			slope := getSlope(points[i], points[j])
			m[slope]++
			if m[slope] > currentMax {
				currentMax = m[slope]
			}
		}
		total := currentMax + duplicates + 1
		if total > maxPoints {
			maxPoints = total
		}
	}
	return maxPoints
}

func getSlope(p1, p2 Point) string {
	dx := p2.X - p1.X
	dy := p2.Y - p1.Y
	gcd := gcd(dx, dy)
	dx /= gcd
	dy /= gcd
	if dx < 0 {
		dx = -dx
		dy = -dy
	} else if dx == 0 {
		dy = 1
	} else if dy == 0 {
		dx = 1
	}
	return fmt.Sprintf("%d,%d", dx, dy)
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}
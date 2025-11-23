package main

type Point struct {
	x int
	y int
}

func (p Point) String() string {
	return "(" + strconv.Itoa(p.x) + "," + strconv.Itoa(p.y) + ")"
}

func maxPoints(points []Point) int {
	if len(points) <= 1 {
		return len(points)
	}
	max := 0
	for i := 0; i < len(points); i++ {
		m := make(map[string]int)
		duplicates := 0
		currentMax := 0
		for j := 0; j < len(points); j++ {
			if i == j {
				continue
			}
			if points[i].x == points[j].x && points[i].y == points[j].y {
				duplicates++
				continue
			}
			dx := points[j].x - points[i].x
			dy := points[j].y - points[i].y
			gcd := gcd(dx, dy)
			dx /= gcd
			dy /= gcd
			slope := strconv.Itoa(dx) + "," + strconv.Itoa(dy)
			m[slope]++
			if m[slope] > currentMax {
				currentMax = m[slope]
			}
		}
		total := currentMax + duplicates + 1
		if total > max {
			max = total
		}
	}
	return max
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}
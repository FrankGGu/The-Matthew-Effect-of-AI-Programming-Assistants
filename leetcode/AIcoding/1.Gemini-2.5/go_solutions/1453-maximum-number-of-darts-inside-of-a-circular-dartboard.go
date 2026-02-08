type Point struct {
	x, y float64
}

func distSq(p1, p2 Point) float64 {
	dx := p1.x - p2.x
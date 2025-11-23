import "math/rand"

type Solution struct {
    radius float64
    x_center float64
    y_center float64
}

func Constructor(radius float64, x_center float64, y_center float64) Solution {
    return Solution{radius: radius, x_center: x_center, y_center: y_center}
}

func (s *Solution) RandPoint() []float64 {
    r := math.Sqrt(rand.Float64()) * s.radius
    theta := rand.Float64() * 2 * math.Pi
    x := s.x_center + r * math.Cos(theta)
    y := s.y_center + r * math.Sin(theta)
    return []float64{x, y}
}
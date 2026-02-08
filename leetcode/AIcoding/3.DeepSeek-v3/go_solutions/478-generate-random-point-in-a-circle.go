import (
	"math"
	"math/rand"
)

type Solution struct {
	radius float64
	x_center float64
	y_center float64
}

func Constructor(radius float64, x_center float64, y_center float64) Solution {
	return Solution{radius, x_center, y_center}
}

func (this *Solution) RandPoint() []float64 {
	r := math.Sqrt(rand.Float64()) * this.radius
	theta := rand.Float64() * 2 * math.Pi
	x := this.x_center + r * math.Cos(theta)
	y := this.y_center + r * math.Sin(theta)
	return []float64{x, y}
}

/**
 * Your Solution object will be instantiated and called as such:
 * obj := Constructor(radius, x_center, y_center);
 * param_1 := obj.RandPoint();
 */
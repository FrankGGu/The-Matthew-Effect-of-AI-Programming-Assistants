import (
	"math"
	"math/rand"
)

type Solution struct {
	radius float64
	xCenter float64
	yCenter float64
}

func Constructor(radius float64, x_center float64, y_center float64) Solution {
	return Solution{
		radius: radius,
		xCenter: x_center,
		yCenter: y_center,
	}
}

func (this *Solution) Gen() []float64 {
	for {
		x := rand.Float64()*2*this.radius - this.radius
		y := rand.Float64()*2*this.radius - this.radius
		if x*x+y*y <= this.radius*this.radius {
			return []float64{this.xCenter + x, this.yCenter + y}
		}
	}
}
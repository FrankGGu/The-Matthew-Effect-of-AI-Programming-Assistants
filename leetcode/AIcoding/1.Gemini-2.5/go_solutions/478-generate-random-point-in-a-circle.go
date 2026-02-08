package main

import (
	"math"
	"math/rand"
)

type Solution struct {
	radius   float64
	x_center float64
	y_center float64
}

func Constructor(radius float64, x_center float64, y_center float64) Solution {
	return Solution{
		radius:   radius,
		x_center: x_center,
		y_center: y_center,
	}
}

func (this *Solution) RandPoint() []float64 {
	theta := rand.Float64() * 2 * math.Pi
	r := math.Sqrt(rand.Float64()) * this.radius

	x := this.x_center + r*math.Cos(theta)
	y := this.y_center + r*math.Sin(theta)

	return []float64{x, y}
}
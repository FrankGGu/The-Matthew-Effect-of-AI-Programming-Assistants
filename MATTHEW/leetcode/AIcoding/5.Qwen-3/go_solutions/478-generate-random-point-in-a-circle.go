package main

type Solution struct {
    radius float64
    x_center float64
    y_center float64
}

func Constructor(radius float64, x_center float64, y_center float64) Solution {
    return Solution{radius, x_center, y_center}
}

func (this *Solution) RandPoint() []int {
    for {
        x := 2 * this.radius * (rand.Float64() - 0.5)
        y := 2 * this.radius * (rand.Float64() - 0.5)
        if x*x + y*y <= this.radius*this.radius {
            return []int{int(this.x_center + x), int(this.y_center + y)}
        }
    }
}
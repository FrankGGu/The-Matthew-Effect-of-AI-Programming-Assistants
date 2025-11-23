import "math"

func twoEggDrop(n int) int {
	return int(math.Ceil((-1 + math.Sqrt(float64(1+8*n))) / 2))
}
import "math"

func judgeSquareSum(c int) bool {
	for a := 0; a <= int(math.Sqrt(float64(c))); a++ {
		bSquare := c - a*a
		b := int(math.Sqrt(float64(bSquare)))
		if b*b == bSquare {
			return true
		}
	}
	return false
}
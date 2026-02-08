import "math"

func closestDivisors(num int) []int {
	a := num + 1
	b := num + 2
	resA := findDivisors(a)
	resB := findDivisors(b)
	if math.Abs(float64(resA[0]-resA[1])) <= math.Abs(float64(resB[0]-resB[1])) {
		return resA
	}
	return resB
}

func findDivisors(num int) []int {
	a := 1
	b := num
	for i := int(math.Sqrt(float64(num))); i >= 1; i-- {
		if num%i == 0 {
			a = i
			b = num / i
			break
		}
	}
	return []int{a, b}
}
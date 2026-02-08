package main

func canMeasureWater(x int, y int, z int) bool {
	if z == 0 {
		return true
	}
	if x + y < z {
		return false
	}
	if x == 0 && y == 0 {
		return false
	}
	if x == 0 {
		return z % y == 0
	}
	if y == 0 {
		return z % x == 0
	}
	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}
	return z%gcd(x, y) == 0
}
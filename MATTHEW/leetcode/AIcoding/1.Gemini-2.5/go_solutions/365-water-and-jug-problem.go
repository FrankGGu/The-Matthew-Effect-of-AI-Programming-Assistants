func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func canMeasureWater(jug1Capacity int, jug2Capacity int, targetCapacity int) bool {
	if targetCapacity == 0 {
		return true
func canMeasureWater(jug1Capacity int, jug2Capacity int, targetCapacity int) bool {
	if targetCapacity > jug1Capacity+jug2Capacity {
		return false
	}
	if targetCapacity == 0 {
		return true
	}

	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	return targetCapacity%gcd(jug1Capacity, jug2Capacity) == 0
}
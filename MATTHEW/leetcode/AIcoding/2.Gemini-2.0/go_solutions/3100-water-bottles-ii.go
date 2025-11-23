func canMeasureWater(jug1Capacity int, jug2Capacity int, targetCapacity int) bool {
	if targetCapacity > jug1Capacity+jug2Capacity {
		return false
	}
	if targetCapacity == 0 {
		return true
	}
	if jug1Capacity == 0 && jug2Capacity == 0 {
		return targetCapacity == 0
	}
	if jug1Capacity == 0 {
		return targetCapacity == jug2Capacity
	}
	if jug2Capacity == 0 {
		return targetCapacity == jug1Capacity
	}

	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	return targetCapacity%gcd(jug1Capacity, jug2Capacity) == 0
}
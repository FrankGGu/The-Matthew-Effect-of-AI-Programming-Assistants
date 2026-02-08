func canMeasureWater(jug1Capacity int, jug2Capacity int, targetCapacity int) bool {
    if jug1Capacity+jug2Capacity < targetCapacity {
        return false
    }
    if jug1Capacity == targetCapacity || jug2Capacity == targetCapacity || jug1Capacity+jug2Capacity == targetCapacity {
        return true
    }
    return targetCapacity%gcd(jug1Capacity, jug2Capacity) == 0
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}
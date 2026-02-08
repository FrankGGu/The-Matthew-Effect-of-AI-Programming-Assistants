func canMeasureWater(x int, y int, z int) bool {
    if z > x+y {
        return false
    }
    if z == 0 || z == x || z == y {
        return true
    }
    return z%gcd(x, y) == 0
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}
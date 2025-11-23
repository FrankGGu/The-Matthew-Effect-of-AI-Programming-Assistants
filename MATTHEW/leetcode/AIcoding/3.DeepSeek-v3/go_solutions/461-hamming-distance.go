func hammingDistance(x int, y int) int {
    xor := x ^ y
    distance := 0
    for xor != 0 {
        distance += xor & 1
        xor >>= 1
    }
    return distance
}
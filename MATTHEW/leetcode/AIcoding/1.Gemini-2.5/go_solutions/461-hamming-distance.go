import "math/bits"

func hammingDistance(x int, y int) int {
    xorResult := x ^ y
    return bits.OnesCount(uint(xorResult))
}
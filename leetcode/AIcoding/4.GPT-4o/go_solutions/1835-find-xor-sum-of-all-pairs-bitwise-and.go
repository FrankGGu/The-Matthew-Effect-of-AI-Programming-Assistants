func getXORSum(A []int, B []int) int {
    xorA, xorB := 0, 0
    for _, num := range A {
        xorA ^= num
    }
    for _, num := range B {
        xorB ^= num
    }
    return xorA & xorB
}